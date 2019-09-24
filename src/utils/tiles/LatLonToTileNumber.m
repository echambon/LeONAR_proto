function tile = LatLonToTileNumber(latitude,longitude,zoom)
%LATLON2TILENUMBER Summary of this function goes here
%   Detailed explanation goes here

n               = 2^zoom;

% Initialization
tile            = Tile;

% X
tile.Column     = floor(n * ((longitude + 180) / 360));

% Y
lat_rad         = deg2rad(latitude);
tile.Line       = floor(n * (1 - (log(tan(lat_rad) + sec(lat_rad)) / pi)) /2);

%% Pixel X, Y coordinates calculation
t_longitude = deg2rad(longitude);
t_latitude  = deg2rad(latitude);
pixelX = 256/2/pi * 2^zoom * (t_longitude + pi);
pixelY = 256/2/pi * 2^zoom * (pi - log(tan(pi/4+t_latitude/2)));

% Taking tiles coordinates away
pixelX = pixelX - 256*tile.Column;
pixelY = pixelY - 256*tile.Line;

% Update reference pixel
tile.RefPixel   = floor([pixelX pixelY]);

end

