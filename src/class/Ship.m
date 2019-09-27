classdef Ship
    %SHIP Class to store Ship GNSS information
    %   Also defines a function to generate a graphical representation of the Ship based on its GNSS data
    
    properties
        Coordinates
        Bearing             = -45 % in degrees, 0° = N, -90° = E, 180° = S, 90° = W
        Altitude            = 0
        Speed               = 0
        GraphicsElement
    end
    
    properties(Access = private)
        MarkerName = 'ship.png'
    end
    
    methods
        function obj = Ship(latitude,longitude)
            obj.Coordinates = Coordinates(latitude,longitude);
            obj = obj.GenerateMapGraphicsElement;
        end
        
        function obj = UpdateShipBearing(obj,bearing)
            obj.Bearing = bearing;
            obj = obj.GenerateMapGraphicsElement;
        end
        
        function obj = GenerateMapGraphicsElement(obj)
            % Read marker shape image
            tmpMarker = imread(obj.MarkerName);
            
            % MapGraphicsElement creation
            obj.GraphicsElement = MapGraphicsElement(tmpMarker,[500 500]); % TODO: manage position
            
            % Rotation
            obj.GraphicsElement = obj.GraphicsElement.Rotate(obj.Bearing);
            
            % Resizing
            obj.GraphicsElement = obj.GraphicsElement.Resize(0.2); % TODO: change magnifier in function of zoom
        end
    end
end

