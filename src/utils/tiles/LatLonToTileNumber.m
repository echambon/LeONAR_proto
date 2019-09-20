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

%% Debug
% Get latitude & longitude of top left pixel of center tile
[t_latitude,t_longitude] = TileNumberToLatLon(tile,zoom);

% Get latitude & longitude of top left pixel of tile directly to the south-east of center tile
SE_tile = tile;
SE_tile.Line = tile.Line + 1;
SE_tile.Column = tile.Column + 1;
[t_latitude_se,t_longitude_se] = TileNumberToLatLon(SE_tile,zoom);

% Compute resolutions
lat_resolution = -(t_longitude-t_longitude_se)/256;
lon_resolution = -(t_latitude-t_latitude_se)/256;

% Affine Transformation Matrix
% A: pixel size in the x-direction in map units/pixel
% D: rotation about y-axis
% B: rotation about x-axis
% E: pixel size in the y-direction in map units, almost always negative
% C: x-coordinate of the center of the upper left pixel
% F: y-coordinate of the center of the upper left pixel
A = lat_resolution;
B = 0;
C = t_longitude;
D = 0;
E = lon_resolution;
F = t_latitude;

% Pixel coordinates in center tile
pixelX = ( E*longitude-B*latitude+B*F-E*C)/(A*E-D*B);
pixelY = (-D*longitude+A*latitude+D*C-A*F)/(A*E-D*B);

% Update reference pixel
tile.RefPixel   = floor([pixelX pixelY]);

end

