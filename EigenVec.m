close all
clc;

% 2x2 matrix with random values from 1 to 10
A = 1 + (10-1)*rand(2);

[V,D]=eig(A);
B = A*V;

eigVec1 = V(:,1);
eigVec2 = V(:,2);
eigVal1 = D(1,1);
eigVal2 = D(2,2);

vec1 = B(:,1);
vec2 = B(:,2);

subplot(2,2,1)
plot(eigVal1*eigVec1,"LineWidth",2)
subplot(2,2,2)
plot(eigVal2*eigVec2,"LineWidth",2)
subplot(2,2,3)
plot(vec1,'m',"LineWidth",2)
subplot(2,2,4)
plot(vec2,'m',"LineWidth",2)