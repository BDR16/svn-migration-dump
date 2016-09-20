function [] = parseCorneringData(fileName, tire, tireID, rimWidth)
    % Load the Matlab data file
    d = importdata(fileName);

    % Collect the relevant columns into a data table
    predata = table(d.SA, d.P, d.FZ, d.IA, d.FX, d.FY, d.NFX, d.NFY, ...
        d.MX, d.MZ, d.RE, d.RL, d.RST, d.TSTC, d.TSTI, d.TSTO, ...
        'VariableNames', {'SA', 'P', 'FZ', 'IA', 'FX', 'FY', 'NFX', 'NFY', ...
        'MX', 'MZ', 'RE', 'RL', 'RST', 'TSTC', 'TSTI', 'TSTO'});

    % Remove spring rate data if it exists
    fz = -1557;  % Force at which the data starts
    fzE = 200;   % Epsilon value for finding the FZ start force
    fzO = 100;   % Data offset for moving the start point backwards
    fzC = 150;   % Cutout value to find the first data sweep
    differences = diff([0; predata{:, 'FZ'} < fz + fzE & predata{:, 'FZ'} > fz - fzE; 0]);
    fzStarts = find(differences == 1);
    fzEnds = find(differences == -1);
    fzLengths = fzEnds - fzStarts;
    dataStart = find(fzLengths > fzC, 1);
    dataStart = max(1, fzStarts(dataStart) - fzO);
    data = predata(dataStart:end, :);

    % Find contiguous zero slip angle sections to identify sweeps
    saE = 0.2;    % Epsilon value for finding a 0 slip angle
    sweepC = 10;  % Cutout value to remove zero crossings in sweeps
    differences = diff([0; data{:, 'SA'} < saE & data{:, 'SA'} > -saE; 0]);
    zStarts = find(differences == 1);
    zEnds = find(differences == -1);
    zLengths = zEnds - zStarts;
    sweepIndices = find(zLengths > sweepC);

    % Plot each sweep based on the run schedule
    % Cutout the first two sweeps because they are conditioning
    cambers = [0, 2, 4, 1, 3];         % Measured in degrees
    loads = [350, 150, 50, 250, 100];  % Measured in lbs
    pressures = [8, 10, 12, 14];       % Measured in psi
    for i = 1:size(sweepIndices, 1)-1
        first = zEnds(sweepIndices(i));
        last = zStarts(sweepIndices(i + 1)) - 1;
        
        % Find what camber, load, and pressure actually are
        [~, cambInd] = min(abs(cambers - round(mean(data{first:last, 'IA'}))));
        camber = cambers(cambInd);
        [~, loadInd] = min(abs(loads + round(mean(data{first:last, 'FZ'}) * 0.225)));
        load = loads(loadInd);
        [~, presInd] = min(abs(pressures - round(mean(data{first:last, 'P'}) * 0.145)));
        pressure = pressures(presInd);
        
        index = getIndex('lat', tireID, rimWidth, pressure, load, camber);
        tire(index) = struct('data', data(first:last, :));
    end
end