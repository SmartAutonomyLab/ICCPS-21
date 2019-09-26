clear
clc

F = [0.1,0.11];
G = [0.1,0.12];
pd_f = makedist('Normal','mu',F(1),'sigma',F(2));
pd_g = makedist('Normal','mu',G(1),'sigma',G(2));
models = [pd_f, pd_g];
x = 0:0.5:1000;
y1 = cdf(pd_f,x);
y2 = cdf(pd_g,x);
D = 0.99 * max(abs(y1-y2));
FPR = 0.1;
TNR =  0.03;

[A, delta, c] = test_function(models, FPR, TNR, D)