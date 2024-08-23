close all
clc;
data = csvread("allData\seismic_data.csv");

% since the dataset is very large thats why we are doing sampling
smapling_interval = 10;
amplitudes = get_sampled_data(data,smapling_interval);
L=length(amplitudes);
t = 0.1*smapling_interval*(0:L-1);
% try for N = [100, 200, 500, 1000]
N = 100;


% plot
figure;
plot(t,amplitudes,'b','DisplayName','Amplitude'); grid on
xlabel('time')
ylabel('Amplitude')
hold on;

% Compute coefficients (See Lecture Notes)
a0 = (1/L)*calc_bounded_area(t,amplitudes);

an=zeros(N);
bn=zeros(N);
for ii = 1:N
    ft1 = amplitudes.*cos(((2*pi*ii)/L)*t);
    ft2 = amplitudes.*sin(((2*pi*ii)/L)*t);
    an(ii) = (2/L)*calc_bounded_area(t,ft1);
    bn(ii) = (2/L)*calc_bounded_area(t,ft2);
end

ft_ii = zeros(1,length(t)) + a0; % Initialize
for ii = 1:N
    fourier_coeff = (an(ii)*cos(((2*pi*ii)/L)*t) + bn(ii)*sin(((2*pi*ii)/L)*t));
    ft_ii = ft_ii + fourier_coeff;
    % plot(t,ft_ii,'LineWidth',2,'DisplayName',['N = ',num2str(ii)]) % Uncomment this line to see ALL of them
end
plot(t,ft_ii,'m','LineWidth',2,'DisplayName',['N = ',num2str(N)])
legend show


function area = calc_bounded_area(x,fx)
    n=length(x);
    area=0;
    for i=1:n-1
        width = x(i+1)-x(i);
        height = (fx(i+1)+fx(i))/2;
        area = area + (height*width);
    end
end


function sampled_data = get_sampled_data(data,si)
    n=length(data);
    sampled_data=[];
    j=1;
    for i=1:si:n
        sampled_data(j)=data(i);
        j=j+1;
    end
end

