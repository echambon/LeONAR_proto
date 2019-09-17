function tile = LatLonToTileNumber(latitude,longitude,zoom)
%LATLON2TILENUMBER Summary of this function goes here
%   Detailed explanation goes here

n               = 2^zoom;

% Initializtion
tile            = Tile;

% X
tile.Column     = floor(n * ((longitude + 180) / 360));

% Y
lat_rad         = deg2rad(latitude);
tile.Line       = floor(n * (1 - (log(tan(lat_rad) + sec(lat_rad)) / pi)) /2);

%% Also store pixel
[tmp_latitude,tmp_longitude] = TileNumberToLatLon(tile,zoom);
error_longitude = longitude - tmp_longitude; % > 0 to the est
error_latitude  = latitude - tmp_latitude; % < 0 to the south

x = error_longitude * n / 360;

lat_rad_error = atan(sinh(pi * (1 - 2*tile.Line / n)))-atan(sinh(pi * (1 - 2 * (tile.Line-1)/n))); % negative toward south
y = error_latitude/rad2deg(lat_rad_error);

% Update reference pixel
tile.RefPixel   = floor([256*x+1 256*y+1]);

end

