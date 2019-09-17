function [latitude_error,longitude_error] = PixelToLatLonError(pixel,tile,zoom)
%PIXELTOLATLONERROR Summary of this function goes here
%   Detailed explanation goes here

%% Pixel coordinates in considered tile
% Pixel x and y coordinates must lie in [1,256]
ErrorIfPointNotInSquare(pixel,1,256,'Pixel coordinates must be within [1,256]')

% [1,1] corresponds to tile top left corner
x = (pixel(1)-1)/256;
y = (pixel(2)-1)/256;

%% Calculation
n                   = 2^zoom;

% Longitude error does not depend on the considered tile
longitude_error     = x / n * 360; % positive towards east ...

% Latitude error depends on the considered tile
lat_rad_error       = atan(sinh(pi * (1 - 2*tile.Line / n)))-atan(sinh(pi * (1 - 2 * (tile.Line-1)/n))); % negative toward south
latitude_error      = y * rad2deg(lat_rad_error);

end

