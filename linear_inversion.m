close all;
clc;

N = 10;

minZ = 1;
maxZ = 10;
Z = (maxZ-minZ).*rand(N,1) + minZ;
Z = sort(Z);

minT = 50;
maxT = 250;
T = (maxT-minT).*rand(N,1) + minT; % for N=10
T = sort(T);
logT = log(T);

%plot
plot(Z, T, 'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')
hold on

% Now we have Linear equation for this problem: logT = log(m1) + m2*Z

% formulate into equation: d = G*m
% final data vector d
d=logT;

% constructing G matrix
G = ones(N,2);
for i=1:N
    G(i,1) = Z(i);
end

% calculating Generalised Inverse
genInvG = inv(G'*G) * G';

% calculating Model Parameters
m = genInvG*d;


% Forward Modelling

n = 100;
% X contains depth values
X = linspace(minZ,maxZ,n);
X_matrix = [X;ones(1,n)];
X_matrix = X_matrix';

Y_matrix = X_matrix*m;

Y = exp(Y_matrix);

plot(X,Y,'b');
xlabel('Depth in Kms  (Z)')
ylabel('Temperature in degree C  (T)')


