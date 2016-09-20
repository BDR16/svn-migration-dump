% Slip angles
tires = {{'43127', 6} {'43127', 7} {'43163', 7} {'43163', 8}};
pressures = [10, 12, 14];
cambers = [0, 1, 2, 3, 4];
loads = [50, 100, 150, 250 ,350];
tireData = containers.Map;
amount = 20;
for i = 1:length(tires)
    tireID = tires{i}{1};
    rimWidth = tires{i}{2};
    index = strcat(tireID, num2str(rimWidth));
    tireData(index) = struct();
    currentTire = tireData(index);
    currentTire.bestPressure = [0 0 0 0 0];
    currentTire.bestCamber = [0 0 0 0 0];
    currentTire.bestValue = [0 0 0 0 0];
    currentTire.bestStr = {};
    for j = 1:length(loads);
        for pressure = pressures
            for camber = cambers
                tireIndex = getIndex('lat', tireID, rimWidth, pressure, loads(j), camber);
                if ~isKey(data, tireIndex)
                    continue;
                end
                sweep = data(tireIndex);
                sorted = sort(sweep.data{:, 'NFY'});
                topAmount = abs(mean(sorted(1:amount)));
                botAmount = abs(mean(sorted(end-amount:end)));
                value = (botAmount + topAmount) / 2;
                if value > currentTire.bestValue(j)
                    currentTire.bestPressure(j) = pressure;
                    currentTire.bestCamber(j) = camber;
                    currentTire.bestValue(j) = value;
                end
            end
        end
        currentTire.bestStr{j} = sprintf('%i, %i\t\t', currentTire.bestPressure(j), currentTire.bestCamber(j));
    end
    disp(sprintf('%s\t%i\t%i\t%i\t%i\t%i', index, currentTire.bestValue(1), currentTire.bestValue(2), currentTire.bestValue(3), currentTire.bestValue(4), currentTire.bestValue(5)));
    disp(sprintf('\t\t\t%s\t%s\t%s\t%s\t%s', currentTire.bestStr{1}, currentTire.bestStr{2}, currentTire.bestStr{3}, currentTire.bestStr{4}, currentTire.bestStr{5}));
end

disp(sprintf('\n'));

% Slip Ratops
pressures = [10, 12, 14];
cambers = [0, 2, 4];
loads = [50, 150, 250 ,350];
tireData2 = containers.Map;
amount = 20;
for i = 1:length(tires)
    tireID = tires{i}{1};
    rimWidth = tires{i}{2};
    index = strcat(tireID, num2str(rimWidth));
    tireData2(index) = struct();
    currentTire = tireData2(index);
    currentTire.bestPressure = [0 0 0 0 0];
    currentTire.bestCamber = [0 0 0 0 0];
    currentTire.bestValue = [0 0 0 0];
    currentTire.bestStr = {};
    for j = 1:length(loads);
        for pressure = pressures
            for camber = cambers
                tireIndex = getIndex('long', tireID, rimWidth, pressure, loads(j), camber, 0);
                if ~isKey(data, tireIndex)
                    continue;
                end
                sweep = data(tireIndex);
                sorted = sort(sweep.data{:, 'NFX'});
                topAmount = abs(mean(sorted(1:amount)));
                botAmount = abs(mean(sorted(end-amount:end)));
                value = (botAmount + topAmount) / 2;
                if value > currentTire.bestValue(j)
                    currentTire.bestPressure(j) = pressure;
                    currentTire.bestCamber(j) = camber;
                    currentTire.bestValue(j) = value;
                end
            end
        end
        currentTire.bestStr{j} = sprintf('%i, %i\t\t', currentTire.bestPressure(j), currentTire.bestCamber(j));
    end
    disp(sprintf('%s\t%i\t%i\t%i\t%i', index, currentTire.bestValue(1), currentTire.bestValue(2), currentTire.bestValue(3), currentTire.bestValue(4)));
    disp(sprintf('\t\t\t%s\t%s\t%s\t%s', currentTire.bestStr{1}, currentTire.bestStr{2}, currentTire.bestStr{3}, currentTire.bestStr{4}));
end