function [latitude,longitude] = PixelTileToLatLon(tile,pixel,zoom)
%PIXELTILETOLATLON Summary of this function goes here
%   Detailed explanation goes here

[tile_latitude,tile_longitude]      = TileNumberToLatLon(tile,zoom);
[error_latitude,error_longitude]    = PixelToLatLonError(pixel,tile,zoom);

latitude    = tile_latitude + error_latitude;
longitude   = tile_longitude + error_longitude;

end

