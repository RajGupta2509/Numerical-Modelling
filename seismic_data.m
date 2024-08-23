close all
clc;

amplitudes = csvread("allData\seismic_data.csv");
L=length(amplitudes);
t = 0.01*(0:L-1);
N=2;


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
    plot(t,ft_ii,'LineWidth',2,'DisplayName',['N = ',num2str(ii)]) % Uncomment this line to see ALL of them
end
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










% ft = @(t) amplitudes;

% % plot
% figure;
% plot(x,fx(x),'k','LineWidth',3,'DisplayName','f(x)'); grid on
% xlabel('x')
% ylabel('f(x)')
% hold on;

% % Compute coefficients (See Lecture Notes)
% a0 = (0.5/pi)*integral(fx,-pi,pi);

% for ii = 1:N
%     fx1 = @(x) fx(x).*cos(ii*x);
%     fx2 = @(x) fx(x).*sin(ii*x);
%     an(ii) = (1/pi)*integral(fx1,-pi,pi);
%     bn(ii) = (1/pi)*integral(fx2,-pi,pi);
% end

% fx_ii = zeros(1,length(x)) + a0; % Initialize
% for ii = 1:N
%     fourier_coeff = (an(ii)*cos(ii*x) + bn(ii)*sin(ii*x));
%     fx_ii = fx_ii + fourier_coeff;
%     plot(x,fx_ii,'LineWidth',2,'DisplayName',['N = ',num2str(ii)]) % Uncomment this line to see ALL of them
% end
% legend show