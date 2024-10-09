% Solves the 1D heat equation with an explicit finite difference scheme
% 
% From Thorsten Becker's webpage
%

clear all
close all
clc;

% Physical parameters
L = 100; % Length of modeled domain [m]
Tmagma = 1200; % Temperature of magma [C]
Trock = 300; % Temperature of country rock [C]
kappa = 1e-6; % Thermal diffusivity of rock [m2/s]
W = 5; % Width of dike [m]
day = 3600*24; % # seconds per day
dt = 1*day; % Timestep [s]

% Numerical parameters
nx = 201; % Number of gridpoints in x-direction
nt = 100; % Number of timesteps to compute
dx = L/(nx-1); % Spacing of grid
x = -L/2:dx:L/2;% Grid

% uncomment the code below to check and verify the stability condition
% ---------------------------Stability Check-------------------------------
% for finding CFL stability condition for heat equation in explicit method
% kappa = (dx^2)/(2*dt);   % so that alpha will be equal to 0.5 
% kappa = kappa + 1e-6;    % increase alpha slightly
% kappa = kappa - 1e-6;    % decrease alpha slightly
% -------------------------------------------------------------------------
% Conclusion:  for condition to be stable,  alpha <= 0.5

% calculate alpha
alpha = (kappa*dt)/(dx^2);


% Setup initial temperature profile
T = ones(size(x))*Trock;
T((abs(x)<=W/2)) = Tmagma;

time = 0;
for n=1:nt % Timestep loop
    % Compute new temperature
    Tnew = zeros(1,nx);
    for i=2:nx-1
        Tnew(i) = alpha*T(i-1) + (1-2*alpha)*T(i) + alpha*T(i+1);
    end
    % Set boundary conditions
    Tnew(1) = T(1);
    Tnew(nx) = T(nx);
    
    % Update temperature and time
    T = Tnew;
    time = time+dt;
    
    % Plot solution
    figure(1), clf
    plot(x,Tnew);
    Ymat(n,:) = n*dt*(ones(1,nx));
    Xmat(n,:) = x;
    Tmat(n,:) = Tnew;
    axis([-50 50 200 1300])
    xlabel('x [m]')
    ylabel('Temperature [^oC]')
    title(['Temperature evolution after ',num2str(time/day),' days'])
    drawnow
end
figure
surf(Xmat,Ymat,Tmat)