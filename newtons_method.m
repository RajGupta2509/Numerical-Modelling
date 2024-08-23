x = -1.5:0.01:2.5; % range of X
N = 6; % number of iterations for finding the root

% actual function
fx = @(x) 2*x.^3 - 3*x.^2 - 3*x + 2;
dfx = @(x) 6*x.^2 - 6*x -3;

% plot
figure;
plot(x,fx(x),'k','LineWidth',3,'DisplayName','f(x)'); grid on
xlabel('x')
ylabel('f(x)')
hold on;

% Iterate over to find roots
x_ii = -0.16;
for ii = 1:N
    x_next = x_ii - fx(x_ii)/dfx(x_ii);
    % y = XXX   %(y - y0) = m(x - x0)
    y = fx(x_ii) + dfx(x_ii)*(x-x_ii);
    % y = fx(x_next);
    
    % plot
    plot(x,y,'LineWidth',2,'DisplayName',['N = ',num2str(ii)])
    % Update x
    x_ii = x_next;
    % print
    disp(sprintf('Iteration = %d, x = %0.3f',ii, x_ii));
end
legend show
plot([x(1) x(end)],[0 0],'--k','DisplayName','x-axis');
plot([0 0],[-10 10],'--k','DisplayName','y-axis');