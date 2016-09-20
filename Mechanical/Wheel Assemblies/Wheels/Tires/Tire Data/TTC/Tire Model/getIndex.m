% Input order is Tire ID, rim width, pressure, load, camber, slip angle
% Omit all inputs that don't exist
function [index] = getIndex(type, tireID, rimWidth, pressure, load, camber, slipAngle)
    if ~exist('slipAngle', 'var')
        slipAngle = '';
    end
    index = strcat(num2str(type), num2str(tireID), num2str(rimWidth), num2str(pressure), ...
        num2str(load), num2str(camber), num2str(slipAngle));
end