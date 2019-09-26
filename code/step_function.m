function [p_xy ,xx ,y_g, y_f, delta] = step_function(x,Fn,y,Gn)
% step function of the calculated ECDFs  
    % x and y are the evaluation point
    %Fn and Gn are corresponding value of ECDF at x and y
    
% syms p_x(t) p_y(t)
% p_x(t) = 0;
% p_y(t) = 0;
% for i = 2 : length(x)
%     p_x(t) = p_x(t) + (Fn(i)-Fn(i-1))*heaviside(t-x(i));
%     p_y(t) = p_y(t) + (Gn(i)-Gn(i-1))*heaviside(t-y(i));
% end
% p_xy = abs(p_x(t)-p_y(t));
% delta = max(p_xy(min(min(x),min(y)):0.01:max(max(x),max(y))));

d = 3;
xxf = [];
xxg = [];
for i = 1 : length(x) - 1
    dxf = (x(i+1) - x(i))/d;
    xxf = [xxf linspace(x(i),x(i+1)-dxf,d)];
    dxg = (y(i+1) - y(i))/d;
    xxg = [xxg linspace(y(i),y(i+1)-dxg,d)];
end

xx = sort([xxf, xxg]);
y_f = [zeros(1,length(xx)-1),1];
y_g = [zeros(1,length(xx)-1),1];

for i = 1 : length(x) - 1
    y_f(xx>x(i) & xx<=x(i+1)) = Fn(i);
    y_g(xx>y(i) & xx<=y(i+1)) = Gn(i);
end

y_f(xx>max(x)) = 1;
y_g(xx>max(y)) = 1;

delta = max(abs(y_f-y_g));
p_xy = abs(y_f-y_g);
end