% Import the tire data
data = importdata('C:\Users\Philip\BR2016\trunk\Mechanical\Wheel Assemblies\Tires\Tire Data\TTC\Tire Model\Round 4\round4.mat');

% Front tire information
tireID = 43127;
rimWidths = [6, 7];

% Rear tire information
% tireID = 43168;
% rimWidths = [7, 8];

% Longitudinal tire test points
pressures = [8, 10, 12, 14];
loads = [50, 150, 250 ,350];
cambers = [0, 2, 4];

% Process lateral curves
newData = zeros(size(rimWidths, 2), size(pressures, 2), size(loads, 2), size(cambers, 2));
type = 'long';
xVar = 'SL';
yVar = 'NFX';
for i = 1:size(rimWidths, 2)
    for j = 1:size(pressures, 2)
        for k = 1:size(loads, 2)
            for l = 1:size(cambers, 2)
                tireDataIndex = getIndex(type, tireID, rimWidths(i), ...
                    pressures(j), loads(k), cambers(l), 0);
                if isKey(data, tireDataIndex)
                    tireData = data(tireDataIndex);
                    xData = tireData.data{:, xVar};
                    yData = tireData.data{:, yVar};
                    fit = getFit(tireData, xVar, yVar, false);
                    newData(i, j, k, l) = fit(3);
%                     title(tireDataIndex);
%                     waitforbuttonpress();
                end
            end
        end
    end
end

% Curve fitting fixes
if tireID == 43127
    % 43127 fixes
    newData(1, 1, 3, 3) = -2.15;
    newData(1, 1, 4, 3) = -1.75;
    newData(1, 2, 3, 2) = -2;
    newData(1, 2, 4, 2) = -1.8;
    newData(1, 2, 4, 3) = -1.8;
    newData(1, 3, 1, 1) = -2.2;
    newData(1, 3, 4, 2) = -1.8;
    newData(1, 4, 3, 2) = -1.85;
    newData(1, 4, 4, 3) = -1.7;
    newData(2, 1, 1, 3) = -3;
    newData(2, 1, 4, 2) = -1.8;
    newData(2, 2, 1, 1) = -2.45;
    newData(2, 2, 3, 1) = -2.1;
    newData(2, 3, 1, 1) = -2.3;
    newData(2, 3, 2, 3) = -2.15;
    newData(2, 3, 4, 3) = -1.75;
elseif tireID == 43168
    % 43168 fixes
    newData(1, 1, 4, 1) = -2.1;
    newData(1, 2, 1, 2) = -2.7;
    newData(1, 3, 4, 1) = -2.1;
    newData(1, 3, 4, 2) = -1.95;
    newData(1, 3, 4, 3) = -1.9;
    newData(1, 4, 4, 3) = -1.8;
    newData(2, 2, 1, 2) = -2.7;
    newData(2, 2, 2, 1) = -2.4;
    newData(2, 2, 4, 2) = -2;
    newData(2, 2, 4, 3) = -2.05;
    newData(2, 3, 4, 3) = -2;
    newData(2, 4, 1, 3) = -2.35;
    newData(2, 4, 4, 3) = -1.8;
end