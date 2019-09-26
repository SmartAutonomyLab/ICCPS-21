function [A, delta, c] = test_function(models, FPR, TNR, D, c, plotOn)

if nargin < 6
    plotOn = 1;
    close all
end
if nargin < 5
    c = 0.9 * D ;
end

m = 1;
n = 1;
[X(1), Y(1)] = sample_from(models);

beta = sqrt(m*n/(m+n));
Hdc(1) = kolmcdf((D-c)*beta);
Hc(1) = kolmcdf((c)*beta);


while (1-Hc(end) > FPR) || (1-Hdc(end) > TNR)
    n = n +1;
    m = m + 1;
    beta = sqrt(m*n/(m+n));
    [X(end + 1), Y(end + 1)] = sample_from(models);
    Hdc(end + 1) = kolmcdf((D-c)*beta);
    Hc(end + 1) = kolmcdf((c)*beta);
end

[Fn,x] = ecdf(X);
[Gn,y] = ecdf(Y);

[~,~,delta] = kstest2(X,Y);


if delta <= c
    A = 1;
else
    A = 0;
end

if plotOn
    h1 = stairs(x,Fn);
    hold on
    h2 = stairs(y,Gn);
    legend([h1;h2],{'$\mathbf{F}_n(x)$','$\mathbf{G}_n(x)$'},'Interpreter','latex')
    xlabel('$x$','Interpreter','latex')
    ylabel('ECDF')
end
end