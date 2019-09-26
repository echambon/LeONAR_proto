function UpdateMapDisplay(app,center)
%UPDATEMAP Summary of this function goes here
%   Detailed explanation goes here

% Clean axes
cla(app.Map);

% Determining center tile
switch class(center)
    case 'Ship'
        tmpCenterTile = LatLonToTileNumber(center.Coordinates.Latitude,center.Coordinates.Longitude,app.mapCurrentZoom);
    case 'Coordinates'
        tmpCenterTile = LatLonToTileNumber(center.Latitude,center.Longitude,app.mapCurrentZoom);
    otherwise
        error('Invalid input');
end

% Updating MapTiled object
app.mapTiles = MapTiled(app.mapFolder,app.mapCurrentZoom,tmpCenterTile,app.mapSize);

% Display updated map
app.mapTiles.DisplayMap(app.Map);

end

