function UpdateMapDisplay(app)
%UPDATEMAP Summary of this function goes here
%   Detailed explanation goes here

% Clean axes
cla(app.Map);

% Updating center tile
app.mapCenterTile   = LatLonToTileNumber(app.userLatitude,app.userLongitude,app.mapCurrentZoom);
app.mapTiles        = MapTiled(app.mapFolder,app.mapCurrentZoom,app.mapCenterTile,app.mapSize);

% Display updated map
app.mapTiles.DisplayMap(app.Map);

end

