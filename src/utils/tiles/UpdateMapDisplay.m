function map_tiles = UpdateMapDisplay(app,center)
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
map_tiles = MapTiled(app.mapFolder,app.mapCurrentZoom,tmpCenterTile,app.mapSize);

%% Update/generate graphics elements
listInteractiveElements = fieldnames(app.mapInteractiveElements);
for iElement = 1:length(listInteractiveElements)
    app.mapInteractiveElements.(listInteractiveElements{iElement}) = ...
        app.mapInteractiveElements.(listInteractiveElements{iElement}).GenerateMapGraphicsElement(app.mapCurrentZoom,map_tiles.Tiles);
end

%% Display updated map
map_tiles = map_tiles.DisplayMap(app.Map,app.mapInteractiveElements);

end

