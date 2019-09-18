function MapSize = DetermineMapSize(width,height)
%DETERMINEMAPSIZE Summary of this function goes here
%   Detailed explanation goes here

MapSize = [ceil(height/256) ceil(width/256)];
% TODO : add + 2 margin ?
% TODO : make sure these are odd numbers ?

end

