function tile = LatLonToTileNumber(latitude,longitude,zoom)
%LATLON2TILENUMBER Summary of this function goes here
%   Detailed explanation goes here

n           = 2^zoom;

% Initializtion
tile        = Tile;

% X
tile.Column = n * ((longitude + 180) / 360);

% Y
lat_rad     = deg2rad(latitude);
tile.Line   = n * (1 - (log(tan(lat_rad) + sec(lat_rad)) / pi)) /2;

end

