classdef Ship
    %SHIP Class to store Ship GNSS information
    %   Also defines a function to generate a graphical representation of the Ship based on its GNSS data
    
    properties
        Coordinates
        Bearing             = -58 % in degrees, 0° = N, -90° = E, 180° = S, 90° = W
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
        end
        
        function obj = UpdateShipBearing(obj,bearing)
            obj.Bearing = bearing;
        end
        
        function obj = GenerateMapGraphicsElement(obj,zoom,tiles)
            % Read marker shape image
            tmpMarker = imread(obj.MarkerName);
            
            % MapGraphicsElement creation with default position
            obj.GraphicsElement = MapGraphicsElement(tmpMarker,[1 1]);
            
            % Rotation
            obj.GraphicsElement = obj.GraphicsElement.Rotate(obj.Bearing);
            
            % Resizing
            dy  = 0.15;
            dx  = 16;
            v   = 0.16;
            zoomFormula = @(x) max(dy/dx*x+(v-dy/dx*17),0.06);
%             obj.GraphicsElement = obj.GraphicsElement.Resize(zoomFormula(zoom));
            
            %% Marker position
            % Get tile and pixel in considered tile where to put element
            tmpMarkerTilePosition = LatLonToTileNumber(obj.Coordinates.Latitude,obj.Coordinates.Longitude,zoom);
            
            % Determine position of top left pixel in map
            [markerTileRow,markerTileColumn] = find(tiles == tmpMarkerTilePosition);
            posX = (markerTileRow-1)*256    + tmpMarkerTilePosition.RefPixel(2);
            posY = (markerTileColumn-1)*256 + tmpMarkerTilePosition.RefPixel(1);
            
            % Update marker position to take marker size into account
            tmpImageSize = size(obj.GraphicsElement.Image);
            posX = posX - floor(tmpImageSize(1)/2);
            posY = posY - floor(tmpImageSize(2)/2);
            obj.GraphicsElement.Position = [posX posY];
        end
    end
end

