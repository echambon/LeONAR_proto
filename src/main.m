function main()
%MAIN LeONAR entry point
%   Appropriately set paths

% Folder where to find main.m
currentFile     = mfilename;
currentFolder   = mfilename('fullpath');
currentFolder   = strrep(currentFolder,currentFile,'');

% Adding subfolders to the path
addpath(genpath(fullfile(currentFolder,'class')));
addpath(genpath(fullfile(currentFolder,'gui')));
addpath(genpath(fullfile(currentFolder,'utils')));
addpath(genpath(fullfile(currentFolder,'inc')));

% Initialize variables
% TODO

% Launching GUI
guimain;

end

