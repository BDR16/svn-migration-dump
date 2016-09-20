% Add the tire models path to make functions callable
addpath('..\');

data = containers.Map;

% Hoosier 20.5x6.0-13
tireID = '43127';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 6\Run Data 13in Cornering Matlab SI\B1654run2.mat', 6}
    {'long', '..\..\Round 6\Run Data 13in Drive Brake Matlab SI\B1654run49.mat', 6}
    {'lat', '..\..\Round 6\Run Data 13in Cornering Matlab SI\B1654run6.mat', 7}
    {'long', '..\..\Round 6\Run Data 13in Drive Brake Matlab SI\B1654run52.mat', 7}
    };
processTire(tireID, tireMatrix, data);

% Hoosier 20.5x7.0-13
tireID = '43163';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 6\Run Data 13in Cornering Matlab SI\B1654run9.mat', 7}
    {'long', '..\..\Round 6\Run Data 13in Drive Brake Matlab SI\B1654run55.mat', 7}
    {'lat', '..\..\Round 6\Run Data 13in Cornering Matlab SI\B1654run12.mat', 8}
    {'long', '..\..\Round 6\Run Data 13in Drive Brake Matlab SI\B1654run58.mat', 8}
    };
processTire(tireID, tireMatrix, data);

save 'round6.mat' data;