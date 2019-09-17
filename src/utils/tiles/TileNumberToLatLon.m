function [latitude,longitude] = TileNumberToLatLon(tile,zoom)
%TILENUMBERTOLATLON Summary of this function goes here
%   latitude:  in degrees
%   longitude: in degrees

n           = 2^zoom;
longitude   = tile.Column / n * 360 - 180;

lat_rad     = atan(sinh(pi * (1 - 2*tile.Line / n)));
latitude    = rad2deg(lat_rad);

end