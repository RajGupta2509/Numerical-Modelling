function [y,m,G] = quad_spline(xi,yi,x)
    % Function for performing quadratic spline interpolation
    % 
    %-------------------
    % Total number of points = N
    % Total number of connecting functions = N-1
    % Total number of unknowns = 3(n-1) % for quadratic
    % Total number of unknowns = 4(n-1) % for cubic (BUT NOT SOLVED HERE)
    % 
    % Dimnesions: 
    % G = 3(N-1) x 3(N-1)
    % m = 3(N-1) x 1
    % d = 3(N-1) x 1
    %-------------------
    
    % check length(xi) == length(yi) 
    if length(xi) ~= length(yi)
        error('Length of input X and input Y must be equal');
    end
    
    n = length(xi);
    
    
    %------------------------------------
    % final data vector of length 3(n-1)
    d = zeros(3*(n-1),1);
    
    % constraint 1
    d(1) = yi(1);
    d(2*(n-1)) = yi(n);
    
    for i = 2:n-1
        j = 2*(i-1);
        d(j) = yi(i);
        d(j+1) = yi(i);
    end
    
    % constraint 2 and contraint 3
    % rest all are zeros
    
    % Final data vector
    d;
    
    %----------------------------------
    % Compute G
    % pre-allocation
    G = zeros(3*(n-1),3*(n-1));
    
    % constraint 1
    % 1st row
    G(1,1) = xi(1)^2;
    G(1,2) = xi(1);
    G(1,3) = 1;
    
    % 2*(n-1)th row
    i = 2*(n-1);
    j = 3*(n-1);
    G(i,j) = 1;
    G(i,j-1) = xi(n);
    G(i,j-2) = xi(n)^2;
    
    k=1;
    for i = 2:n-1
        j = 2*(i-1);
        G(j,k) = xi(i)^2;
        G(j,k+1) = xi(i);
        G(j,k+2) = 1;
    
        j=j+1;
        k=k+3;
        G(j,k) = xi(i)^2;
        G(j,k+1) = xi(i);
        G(j,k+2) = 1;
    
    end
    
    
    % Constraint 2
    j = 2*(n-1) + 1;
    k = 1;
    for i=2:n-1
        G(j,k) = 2*xi(i);
        G(j,k+1) = 1;
        G(j,k+2) = 0;
        G(j,k+3) = -2*xi(i);
        G(j,k+4) = -1;
    
        j=j+1;
        k=k+3;
    end
    
    % Constraint 3
    G(3*(n-1),1) = 1;
    %-----------------------------
    
    % compute coefficients
    m = inv(G)*d;
    
    
    % Compute polynomials 
    % preAllocation
    y = zeros(length(x),1);
    
    j = 1;
    k = 1;
    for i = 1:length(x)
        if x(i) > xi(j+1)
            j=j+1;
            k=k+3;
        end
        
        y(i) =  (m(k) * x(i)^2) + (m(k+1) * x(i)) + (m(k+2)*1);
        
    end
    
    % count = 1; 
    % for i = 1:length(x)-1
    %     y0 = y(i); y1 = y(i+1);
    %     x0 = x(i); x1 = x(i+1);
    % 
end

%% =================================================
% EXAMPLE
if true
    % clear all;
    close all;
    clc;
    n = 10;
    xi = linspace(-1,1,n);
    x = linspace(-1,1,1000);
    % Test Example
    yi = [3 2 2 1 0 -3 -4 1 2 4];
    %yi = [3 2 2 1 0 -3 -4 1 2 4 3 2 2 1 0 -3 -4 1 2 4]; % for n=10
    
    % Function Call
    [y2,m,G] = quad_spline(xi,yi,x);
    
    y3 = interp1(xi,yi,x,'spline');
    
    %plot
    plot(xi, yi, 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')
    hold on
    
    % plot
    plot(x,y2,'Linewidth',2,'Displayname','quadratic spline');
    % plot
    plot(x,y3,'Linewidth',2,'Displayname','in-built cubic spline');
    legend
end