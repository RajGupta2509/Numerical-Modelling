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
    
    x_mid = (x0+x1)/2;

    y=(0)*n;
    for i=1:n
        if x(i)<x_mid
            y(i) = y0;
        else
            y(i) = y1;
        end
    end
    
    plot(x,y)
end