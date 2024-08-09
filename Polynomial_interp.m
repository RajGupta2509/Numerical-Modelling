close all;
clc;

N = 5;
x = linspace(1,10,N); % check the dimension
y = randi(10,[1,N]);

%plot
plot(x, y, 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')

y = y';

% prepare G matrix  - Dimension (N x N)
%    [x0^0  x0^1  x0^2 ..... x0^(N-1)]
%    |x1^0  x1^1  x1^2 ..... x1^(N-1)|
%    |x2^0  x2^1  x2^2 ..... x2^(N-1)|
%G = |x3^0  x3^1  x3^2 ..... x3^(N-1)|
%    |:  :   :     :     :    :  |
%    [xN^0  xN^1  xN^2 ..... xN^(N-1)]

G=[[0]*N]*N;

for i=1:N
    for j=1:N
        G(i,j) = x(i)^(j-1);
    end
end

% m is column vector (N x 1) 
m = inv(G)*y;  

xi = linspace(x(1),x(end),1000);

xi = xi';

% yi = [1 xi^1 xi^2 xi^3 ..... xi^(n-1)] * m % (1000 x N) (N x 1) 

yi=linspace(0,0,1000);

for i=1:1000
    for j=1:N
        yi(i) = yi(i) + (xi(i)^(j-1))*m(j);
    end
end

hold on
plot(xi,yi)

