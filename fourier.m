close all
clc;

x = -pi:0.01:pi; % range of X
N = 10; % number of fourier coefficients

% actual function
% here we can define any function and no need to make changes anywhere else, as the written code is generallised for any function fx(x) and expeacted result will be plotted
fx = @(x) (x.^2).*cos(2*x);

% plot
figure;
plot(x,fx(x),'k','LineWidth',3,'DisplayName','f(x)'); grid on
xlabel('x')
ylabel('f(x)')
hold on;

% Compute coefficients (See Lecture Notes)
a0 = (0.5/pi)*integral(fx,-pi,pi);

for ii = 1:N
    fx1 = @(x) fx(x).*cos(ii*x);
    fx2 = @(x) fx(x).*sin(ii*x);
    an(ii) = (1/pi)*integral(fx1,-pi,pi);
    bn(ii) = (1/pi)*integral(fx2,-pi,pi);
end

fx_ii = zeros(1,length(x)) + a0; % Initialize
for ii = 1:N
    fourier_coeff = (an(ii)*cos(ii*x) + bn(ii)*sin(ii*x));
    fx_ii = fx_ii + fourier_coeff;
    plot(x,fx_ii,'LineWidth',2,'DisplayName',['N = ',num2str(ii)]) % Uncomment this line to see ALL of them
end
legend show
