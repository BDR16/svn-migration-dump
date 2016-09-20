function [] = processTire(tireID, tireMatrix, tire)
    % Fits
    latFits = {
        {'SA', 'NFY'}
%         {'SA', 'MX'}
%         {'SA', 'MZ'}
        };
    longFits = {
        {'SL', 'NFX'}
%         {'SL', 'MX'}
%         {'SL', 'MZ'}
        };
    
    % Loop through each row of the tire matrix
    for i = 1:length(tireMatrix)
        % Define variables
        parser = tireMatrix{i}{1};
        dataFileName = tireMatrix{i}{2};
        rimWidth = tireMatrix{i}{3};
        
        % Parse the data
        if strcmp(parser, 'lat')
            parseCorneringData(dataFileName, tire, tireID, rimWidth);
            fits = latFits;
        elseif strcmp(parser, 'long')
            parseDriveBrakeData(dataFileName, tire, tireID, rimWidth);
            fits = longFits;
        else
            error('Unknown data parser "%s".', parser);
        end
        
        % Get the expected fits
        for j = 1:length(fits)
            for sweep = keys(tire)
                c = getFit(tire(sweep{1}), fits{j}{1}, fits{j}{2});
                sweepStruct = tire(sweep{1});
                sweepStruct.(strcat(fits{j}{1}, fits{j}{2})) = c;
                tire(sweep{1}) = sweepStruct;
            end
        end
    end
end