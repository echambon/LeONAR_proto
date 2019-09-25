function [minZoom,maxZoom] = GetMinMaxZoomFromTilesFolder(tiles_folder)
%GETMINMAXZOOM Summary of this function goes here
%   Detailed explanation goes here

% Checking last character is \ or /
t_tiles_folder = tiles_folder;
if ~strcmp(t_tiles_folder,filesep)
    t_tiles_folder = [t_tiles_folder filesep];
end

% Listing files and folders in tiles_folder
files = dir(t_tiles_folder);

% Identifying folders
dirFlags = [files.isdir];

% Identifying real folders i.e. not '.' or '..'
realDirFlags = cellfun(@(x)~(strcmp(x,'.') || strcmp(x,'..')),{files.name});

% Extracting subfolders
subFolders = files(dirFlags & realDirFlags);

% Subfolders names and conversion to numeric type
subFoldersNames = {subFolders.name};
zoomLevels = cellfun(@(x)str2double(x),subFoldersNames);

% Check if we are really in a tiles folder
if isempty(zoomLevels) || any(isnan(zoomLevels))
    error('folder is not a tile folder');
end

% Deduction of min and max zoom levels
minZoom = min(zoomLevels);
maxZoom = max(zoomLevels);

% Protect against zoom level 0
minZoom = max(minZoom,1);

end

