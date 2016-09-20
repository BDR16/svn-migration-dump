function [] = parseDriveBrakeData(fileName, tire, tireID, rimWidth)
    % Load the Matlab data file
    d = importdata(fileName);

    % Collect the relevant columns into a data table
    data = table(d.SA, d.SL, d.SR, d.P, d.FZ, d.IA, d.FX, d.FY, d.NFX, d.NFY, ...
        d.MX, d.MZ, d.RE, d.RL, d.RST, d.TSTC, d.TSTI, d.TSTO, ...
        'VariableNames', {'SA', 'SL', 'SR', 'P', 'FZ', 'IA', 'FX', 'FY', 'NFX', 'NFY', ...
        'MX', 'MZ', 'RE', 'RL', 'RST', 'TSTC', 'TSTI', 'TSTO'});

    % Find contiguous zero slip ratio sections to identify sweeps
    iaE = 1;  % Epsilon value for finding a large changing camber
    differences = diff(data{:, 'IA'});
    iaIndices = find(differences > iaE | differences < -iaE);
    iaIndices = [0; iaIndices; size(data{:, 'IA'}, 1)];

    % Plot each sweep based on the run schedule
    % Cutout the first two sweeps because they are conditioning
    slipAngles = [0, 3, 6];       % Measured in degrees
    loads = [350, 150, 250, 50];  % Measured in lbs
    cambers = [0, 2, 4];          % Measured in degrees
    pressures = [8, 10, 12, 14];  % Measured in psi
    for i = 1:size(iaIndices, 1)-1
        first = iaIndices(i) + 1;
        last = iaIndices(i + 1);
        
        % Find what camber, load, and pressure actually are
        [~, slipInd] = min(abs(slipAngles - round(mean(data{first:last, 'SA'}))));
        slipAngle = slipAngles(slipInd);
        [~, cambInd] = min(abs(cambers - round(mean(data{first:last, 'IA'}))));
        camber = cambers(cambInd);
        [~, loadInd] = min(abs(loads + round(mean(data{first:last, 'FZ'}) * 0.225)));
        load = loads(loadInd);
        [~, presInd] = min(abs(pressures - round(mean(data{first:last, 'P'}) * 0.145)));
        pressure = pressures(presInd);
        
        index = getIndex('long', tireID, rimWidth, pressure, load, camber, slipAngle);
        tire(index) = struct('data', data(first:last, :));
    end
end