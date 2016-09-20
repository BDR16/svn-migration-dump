function [c] = pacejkaFit(x, y, c0, plotIt)
%     lowerBounds = [-10, -3, c0(3) - 2, -10];
%     upperBounds = [13, 3, c0(3) + 2, 10];
    opts = optimset('MaxFunEvals', 10000, 'MaxIter', 5000);

    magicFormula = @(c, xData)c(3) * sin(c(2) * atan(c(1) * (1 - c(4)) * xData + c(4) * atan(c(1) * xData)));
    [c, ~, ~, ~, ~] = lsqcurvefit(magicFormula, c0, x, y, [], [], opts);
    if exist('plotIt', 'var') && plotIt
        plot(x, magicFormula(c, x));
        hold on;
        plot(x, y, '.');
        leg = legend(num2str(c));
        set(leg, 'Location', 'east');
        hold off;
    end
end