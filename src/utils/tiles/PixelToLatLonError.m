function [latitude_error,longitude_error] = PixelToLatLonError(pixel,tile,zoom)
%PIXELTOLATLONERROR Summary of this function goes here
%   Detailed explanation goes here

% Pixel coordinates in considered tile
% [1,1] corresponds to tile top left corner
x = pixel(1)/256;
y = pixel(2)/256;

% Calculation
n                   = 2^zoom;

% Longitude error does not depend on the considered tile
longitude_error     = x / n * 360; % positive towards east ...

% Latitude error depends on the considered tile
lat_rad_error       = atan(sinh(pi * (1 - 2*tile.Line / n)))-atan(sinh(pi * (1 - 2 * (tile.Line-1)/n))); % negative toward south
latitude_error      = y * rad2deg(lat_rad_error);

end

