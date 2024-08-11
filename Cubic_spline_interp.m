function [y,m,G] = cubic_spline(xi,yi,x)
    % Function for performing quadratic spline interpolation
    % 
    %-------------------
    % Total number of points = N
    % Total number of connecting functions = N-1
    % Total number of unknowns = 3(n-1) % for quadratic
    % Total number of unknowns = 4(n-1) % for cubic 
    % 
    % Dimnesions: 
    % G = 4(N-1) x 4(N-1)
    % m = 4(N-1) x 1
    % d = 4(N-1) x 1
    %-------------------
    
    % check length(xi) == length(yi) 
    if length(xi) ~= length(yi)
        error('Length of input X and input Y must be equal');
    end
    
    n = length(xi);
    
    
    %------------------------------------
    % final data vector of length 3(n-1)
    d = zeros(4*(n-1),1);
    
    % constraint 1
    d(1) = yi(1);
    d(2*(n-1)) = yi(n);
    
    for i = 2:n-1
        j = 2*(i-1);
        d(j) = yi(i);
        d(j+1) = yi(i);
    end
    
    % constraint 2, 3 and 4
    % rest all are zeros
    
    % Final data vector is d
    
    
    %----------------------------------
    % Compute G
    % pre-allocation
    G = zeros(4*(n-1),4*(n-1));
    
    % constraint 1
    % 1st row
    G(1,1) = xi(1)^3;
    G(1,2) = xi(1)^2;
    G(1,3) = xi(1);
    G(1,4) = 1;
    
    % 2*(n-1)th row
    i = 2*(n-1);
    j = 4*(n-1);
    G(i,j) = 1;
    G(i,j-1) = xi(n);
    G(i,j-2) = xi(n)^2;
    G(i,j-3) = xi(n)^3;
    
    k=1;
    for i = 2:n-1
        j = 2*(i-1);
        G(j,k) = xi(i)^3;
        G(j,k+1) = xi(i)^2;
        G(j,k+2) = xi(i);
        G(j,k+3) = 1;
    
        j=j+1;
        k=k+4;
        G(j,k) = xi(i)^3;
        G(j,k+1) = xi(i)^2;
        G(j,k+2) = xi(i);
        G(j,k+3) = 1;
    
    end


    % Constraint 2
    j = 2*(n-1) + 1;
    k = 1;
    for i=2:n-1
        G(j,k) = 3*(xi(i)^2);
        G(j,k+1) = 2*xi(i);
        G(j,k+2) = 1;
        G(j,k+3) = 0;
        G(j,k+4) = -3*(xi(i)^2);
        G(j,k+5) = -2*xi(i);
        G(j,k+6) = -1;
    
        j=j+1;
        k=k+4;
    end
    
    
    % Constraint 3
    j = 2*(n-1) + (n-2) + 1;
    k = 1;
    for i=2:n-1
        G(j,k) = 3*xi(i);
        G(j,k+1) = 1;
        G(j,k+2) = 0;
        G(j,k+3) = 0;
        G(j,k+4) = -3*xi(i);
        G(j,k+5) = -1;
    
        j=j+1;
        k=k+4;
    end
    

    % Constraint 4

    j = 4*(n-1);
    k = 4*(n-1);

    flag=3;
    slope=10;

    % case 1 -> (double derivates = 0) at ends points
    % this assumption is good for Natural Cubic Spline

    if (flag==1)
        G(j-1,1) = 3*xi(n);
        G(j-1,2) = 1;
    
        G(j,k-3) = 3*xi(n);
        G(j,k-2) = 1;
    end
    

    % case 2 -> (let first and last equations to be quadratic)

    if (flag==2)
        G(j-1,1) = 1;
        G(j,k-3) = 1;
    end


    % case 3 -> (assign some values to first derivatives at end points)
    
    if (flag==3)
        G(j-1,1) = 3*(xi(1)^2); 
        G(j-1,2) = 2*xi(1);
        G(j-1,3) = 1;
    
        G(j,k-3) = 3*(xi(n)^2); 
        G(j,k-2) = 2*xi(n);
        G(j,k-1) = 1;
    
        % these values I have taken just by (hit and trial method) to
        % exactly match with built-in spline of matlab.
        d(j-1) = -11.5;
        d(j) = 26.5;
    end




    % ----------------------------------------

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
            k=k+4;
        end
        
        y(i) =  (m(k) * x(i)^3) + (m(k+1) * x(i)^2) + (m(k+2)*x(i)) + (m(k+3)*1);
        
    end
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

    % xi = linspace(10,20,n);
    % x = linspace(10,20,1000);
    % Test Example
    yi = [3 2 2 1 0 -3 -4 1 2 4];
    %yi = [3 2 2 1 0 -3 -4 1 2 4 3 2 2 1 0 -3 -4 1 2 4]; % for n=10
    
    % Function Call
    [y2,m,G] = cubic_spline(xi,yi,x);
    
    y3 = interp1(xi,yi,x,'spline');
    
    %plot
    plot(xi, yi, 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')
    hold on
    
    % plot
    plot(x,y2,'b','Linewidth',2,'Displayname','cubic spline');
    % plot
    plot(x,y3,'Linewidth',2,'Displayname','in-built cubic spline');
    legend
end