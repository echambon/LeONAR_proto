classdef MapGraphicsElement
    %MAPELEMENT Graphical element to diaply on map
    %   Detailed explanation goes here
    
    properties
        Image               % image matrix (R,G,B array)
        Position = [1 1]    % position in the map of top left pixel
    end
    
    methods
        function obj = MapGraphicsElement(image,position)
            obj.Image       = image;
            obj.Position    = position;
        end
    end
end

