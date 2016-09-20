% Add the tire models path to make functions callable
addpath('..\');

data = containers.Map;

% Hoosier 20.5x7.0-13
tireID = '43163';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run14.mat', 6}
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run15.mat', 6}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run42.mat', 6}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run43.mat', 6}
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run16.mat', 7}
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run17.mat', 7}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run45.mat', 7}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run46.mat', 7}
    };
processTire(tireID, tireMatrix, data);

% Goodyear 20.0x7.0-13
tireID = 'D2704';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run10.mat', 7}
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run11.mat', 7}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run54.mat', 7}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run55.mat', 7}
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run12.mat', 8}
    {'lat', '..\..\Round 5\Raw Data Cornering Matlab SI\B1464run13.mat', 8}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run57.mat', 8}
    {'long', '..\..\Round 5\Raw Data Drive Brake Matlab SI\B1464run58.mat', 8}
    };
processTire(tireID, tireMatrix, data);

save 'round5.mat' data;