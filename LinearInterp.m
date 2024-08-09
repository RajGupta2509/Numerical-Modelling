close all;
clc;

N = 10;
xi = linspace(-1,1,N);
yi = [3 2 2 1 0 -3 -4 1 2 4]; % for N=10

%plot
plot(xi, yi, 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')


hold on
n = 100;
for i=1:N-1
    y0 = yi(i); y1 = yi(i+1);
    x0 = xi(i); x1 = xi(i+1);
    
    x = linspace(x0,x1,n);
    
    % main concept: Eq of a line=>  y = m*x + c
    y = y0 + (x - x0)*(y1 - y0)/(x1 - x0);
    
    plot(x,y)
end