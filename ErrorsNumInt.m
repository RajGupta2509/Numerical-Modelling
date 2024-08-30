close all
clc;

% Make an example Parabola
% y = ax^2 + bx + c

% Input coefficients
a = -1;
b = 4;
c = 0;

% Intialize x
x = -1:0.01:5;

% Initialize function
f = @(a,b,c,x) a*x.^2 + b*x + c;

xmin = 0; xmax = 4;
N = 20;

% Area using actual Integration
fx = @(x) f(a,b,c,x);
trueArea = integral(fx,xmin,xmax);

trpzErrors = zeros(1);
midPntErrors = zeros(1);
simpErrors = zeros(1);

for n = 2:N
    % Discretize X 
    x_sampled = linspace(xmin,xmax,n);

    trpzArea = trapezoidalArea(x_sampled,fx,n);
    midPntArea = midPointArea(x_sampled,fx,n);
    simpArea = simsonsArea(x_sampled,fx,n);

    trpzErrors(n) = abs(trpzArea-trueArea);
    midPntErrors(n) = abs(midPntArea-trueArea);
    simpErrors(n) = abs(simpArea-trueArea);
end

% Plotting Nsamples vs Errors
Nsamples = linspace(1,N,N);
subplot(3,1,1)
scatter(Nsamples,trpzErrors,'filled')
xlim([1.1,N+1])
xlabel("Nsamples")
ylabel("Error")
title("Error in Trapezoidal Area")
subplot(3,1,2)
scatter(Nsamples,midPntErrors,'filled')
xlim([1.1,N+1])
xlabel("Nsamples")
ylabel("Error")
title("Error in Mid-Point Area")
subplot(3,1,3)
scatter(Nsamples,simpErrors,'filled')
xlim([1.1,N+1])
xlabel("Nsamples")
ylabel("Error")
title("Error in Simpson's Area")


function area = trapezoidalArea(x,fx,n)
    y=fx(x);
    area=0;
    for i=1:n-1
        area = area + ((x(i+1)-x(i))*(y(i+1)+y(i))/2);
    end
end


function area = midPointArea(x,fx,n)
    % Find mid-points of x
    x_mid = conv(x,[0.5 0.5],'valid');
    % Y- points at mid-points for summation
    y_mid = fx(x_mid);

    area=0;
    for i=1:n-1
        area = area + ((x(i+1)-x(i))*y_mid(i));
    end
end


function area = simsonsArea(x,fx,n)
    y=fx(x);
    h = x(2)-x(1);
    if mod(n,2)==1 
        % odd number of points (even number of intervals) % 1/3 rule
        % See class notes for derivation
        area=y(1)+y(n);
        for i=2:n-1
            if mod(i,2)==0
                val = 4*y(i);
            else
                val = 2*y(i); 
            end
            area = area + val;
        end
        area = (h/3)*area;
    else
        % even number of points
        % odd number of intervals (mod(N,2) == 0); % 3/8 rule
        % https://en.wikipedia.org/wiki/Simpson's_rule#Simpson.27s_3.2F8_rule
        % area1 = (3*h/8)*(y(1) + sum(3*y(2:3:end-2)) + sum(3*y(3:3:end-1)) + sum(2*y(4:3:end-4)) + y(end));
        area=y(1)+y(n);
        for i=2:n-1
            if mod(i-1,3)==0
                val = 2*y(i);
            else
                val = 3*y(i); 
            end
            area = area + val;
        end
        area = (3*h/8)*area;
    end
    
end

