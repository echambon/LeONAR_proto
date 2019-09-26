classdef Ship
    %SHIP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Coordinates
        Bearing     = 0
        Altitude    = 0
        Speed       = 0
    end
    
    methods
        function obj = Ship(latitude,longitude)
            obj.Coordinates = Coordinates(latitude,longitude);
        end
    end
end

