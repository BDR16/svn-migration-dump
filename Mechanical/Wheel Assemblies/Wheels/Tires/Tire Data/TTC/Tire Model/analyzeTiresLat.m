% Import the tire data
data = importdata('C:\Users\Philip\BR2016\trunk\Mechanical\Wheel Assemblies\Tires\Tire Data\TTC\Tire Model\Round 4\round4.mat');

% Front tire information
% tireID = 43127;
% rimWidths = [6, 7];

% Rear tire information
tireID = 43168;
rimWidths = [7, 8];

% Lateral tire test points
latPressures = [8, 10, 12, 14];
latLoads = [50, 100, 150, 250 ,350];
latCambers = [0, 1, 2, 3, 4];

% Longitudinal tire test points
longPressures = [8, 10, 12, 14];
longLoads = [50, 150, 250 ,350];
longCambers = [0, 2, 4];

% Process lateral curves
newData = zeros(size(rimWidths, 2), size(latPressures, 2), size(latLoads, 2), size(latCambers, 2));
type = 'lat';
xVar = 'SA';
yVar = 'NFY';
for i = 1:size(rimWidths, 2)
    for j = 1:size(latPressures, 2)
        for k = 1:size(latLoads, 2)
            for l = 1:size(latCambers, 2)
                tireDataIndex = getIndex(type, tireID, rimWidths(i), ...
                    latPressures(j), latLoads(k), latCambers(l));
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
    newData(1, 1, 5, 1) = 2;
    newData(1, 1, 5, 2) = 2;
    newData(1, 1, 5, 3) = 2;
    newData(1, 1, 5, 4) = 2;
    newData(1, 1, 5, 5) = 2;

    newData(2, 4, 1, 1) = 2.4;
    newData(2, 4, 1, 2) = 2.4;
    newData(2, 4, 1, 3) = 2.4;

    newData(2, 4, 5, 1) = 1.95;
elseif tireID == 43168
    % 43168 fixes
    newData(1, 4, 5, 1) = 2.35;
    newData(2, 2, 4, 5) = 2.45;

    newData(2, 3, 3, 3) = 2.5;
    newData(2, 3, 3, 5) = 2.3;

    newData(2, 3, 4, 3) = 2.5;
    newData(2, 3, 4, 4) = 2.4;
    newData(2, 3, 4, 5) = 2.3;

    newData(2, 4, 4, 1) = 2.5;
    newData(2, 4, 4, 2) = 2.4;
    newData(2, 4, 4, 3) = 2.4;
    newData(2, 4, 4, 4) = 2.3;
    newData(2, 4, 4, 5) = 2.2;

    newData(2, 4, 5, 1) = 2.45;
    newData(2, 4, 5, 2) = 2.4;
end