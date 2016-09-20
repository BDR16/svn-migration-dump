function [c] = getFit(sweep, xType, yType, plotIt)
    % Define c0 values for all curve types
    fitTypes = containers.Map;
    stiffness = 0.5;
    latShape = 1.6;
    longShape = 1.65;
    peak = max(sweep.data{:, yType});
    curvature = 1;
    fitTypes('SAFY') = [stiffness, latShape, peak, curvature];
    fitTypes('SANFY') = [stiffness, latShape, peak, curvature];
    fitTypes('SAMX') = [stiffness, latShape, peak, curvature];
    fitTypes('SAMZ') = [stiffness, latShape, peak, curvature];
    fitTypes('SLNFX') = [stiffness, longShape, -1 * peak, curvature];
    fitTypes('SLMX') = [stiffness, longShape, peak, curvature];
    fitTypes('SLMZ') = [stiffness, longShape, peak, curvature];
    
    % Check if given fit type exists
    fitType = strcat(xType, yType);
    if ~isKey(fitTypes, fitType)
        error('Fit type "%s" does not exist.', fitType);
    end
    
    % Get the fit
    c0 = fitTypes(fitType);
    c = pacejkaFit(sweep.data{:, xType}, sweep.data{:, yType}, c0, plotIt);
end