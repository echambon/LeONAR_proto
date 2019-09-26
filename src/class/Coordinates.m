classdef Coordinates
    %COORDINATES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Latitude
        Longitude
    end
    
    methods
        function obj = Coordinates(latitude,longitude)
            obj.Latitude    = latitude;
            obj.Longitude   = longitude;
        end
    end
end

