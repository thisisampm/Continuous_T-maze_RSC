function [R, p] = fit_line_hold(X,Y)
%fits a line to a scatterplot of X,Y

poly=polyfit(X(~isnan(X) & ~isnan(Y)),Y(~isnan(X) & ~isnan(Y)),1);
fit_x = (min(X)-(range(X)/4)):(range(X)/100):(max(X)+(range(X)/4));
fit_y=polyval(poly, fit_x);
%figure;
hold on; plot(X,Y,'ro');plot(fit_x, fit_y, 'r-', 'LineWidth', 2)

[R, p] = corr(X(~isnan(X) & ~isnan(Y)),Y(~isnan(X) & ~isnan(Y)));

end