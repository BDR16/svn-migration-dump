% Add the tire models path to make functions callable
addpath('..\');

data = containers.Map;

% Hoosier 20.5x6.0-13
tireID = '43127';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run38.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run36.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run39.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run37.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run116.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run114.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run117.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run115.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run43.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run41.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run44.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run42.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run110.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run107.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run111.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run109.mat', 7}
    };
processTire(tireID, tireMatrix, data);

% Hoosier 20.5x7.0-13
tireID = '43163';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run48.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run46.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run49.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run47.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run122.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run120.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run123.mat', 6}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run121.mat', 6}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run53.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run51.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run54.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run52.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run128.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run126.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run129.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run127.mat', 7}
    };

processTire(tireID, tireMatrix, data);
% Hoosier 20.5x7.5-13
tireID = '43168';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run56.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run59.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run57.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run134.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run132.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run135.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run133.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run62.mat', 8}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run65.mat', 8}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run63.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run140.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run138.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run141.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run139.mat', 8}
    };
processTire(tireID, tireMatrix, data);

% Goodyear 20.0x7.0-13
tireID = '2646';
tireMatrix = {
    % parser, dataFileName, rimWidth
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run17.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run15.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run18.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run16.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run96.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run94.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run97.mat', 7}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run95.mat', 7}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run20.mat', 8}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run23.mat', 8}
    {'lat', '..\..\Round 4\Raw Data Matlab Metric Runs 1-50\B1320run21.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run102.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 51-100\B1320run100.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run103.mat', 8}
    {'long', '..\..\Round 4\Raw Data Matlab Metric Runs 101-157\B1320run101.mat', 8}
    };
processTire(tireID, tireMatrix, data);

save 'round4.mat' data;