function A = test_function(models, FPR, TNR, D, plotOn)

if nargin < 5
    plotOn = 1;
end
m = 1;
n = 1;
[X(1), Y(1)] = sample_from(models);
[~,~,delta] = kstest2(X,Y);
beta = sqrt(m*n/(m+n));
Hdc(1) = kolmcdf(max(0, D-delta)*beta);
Hc(1) = kolmcdf(delta*beta);


while (1)
    n = n +1;
    m = m + 1;
    beta = sqrt(m*n/(m+n));
    [X(end + 1), Y(end + 1)] = sample_from(models);
    
    [~,~,delta] = kstest2(X,Y);
    
    Hdc(end + 1) = kolmcdf(max(0, D-delta)*beta);
    Hc(end + 1) = kolmcdf(delta*beta);
    
    if 1-Hc(end) < FPR
        A= 0;
        break
    elseif 1-Hdc(end) < TNR
        A = 1;
        break
    end
end


if plotOn
    [Fn,x] = ecdf(X);
    [Gn,y] = ecdf(Y);
    h1 = stairs(x,Fn);
    hold on
    h2 = stairs(y,Gn);
    legend([h1;h2],{'$\mathbf{F}_n(x)$','$\mathbf{G}_n(x)$'},'Interpreter','latex')
    xlabel('$x$','Interpreter','latex')
    ylabel('ECDF')
end
end
