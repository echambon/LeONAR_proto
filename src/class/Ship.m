classdef Ship
    %SHIP Class to store Ship GNSS information
    %   Also defines a function to generate a graphical representation of the Ship based on its GNSS data
    
    properties
        Coordinates
        Bearing     = 0 % in degrees, 0° = N, -90° = E, 180° = S, 90° = W
        Altitude    = 0
        Speed       = 0
        ShipMarker  = [] % Image representation of the ship
    end
    
    properties(Access = private)
        MarkerName = 'marker.png'
    end
    
    methods
        function obj = Ship(latitude,longitude)
            obj.Coordinates = Coordinates(latitude,longitude);
            obj.GenerateShipMarker;
        end
        
        function obj = UpdateShipBearing(obj,bearing)
            obj.Bearing = bearing;
            obj.GenerateShipMarker;
        end
        
        function obj = GenerateShipMarker(obj)
            % Read marker shape image
            [tmpMarker,~,~] = imread(obj.MarkerName); % with other outputs to get alpha channel
            
            % Rotate marker
            tmpMarkerRotated = zeros(size(tmpMarker));
            
            midx = floor(size(tmpMarkerRotated,2)/2);
            midy = floor(size(tmpMarkerRotated,1)/2);
            tmpBearingRad = deg2rad(obj.Bearing);
            
            for kk = 1:size(tmpMarkerRotated,3)
                for ii = 1:size(tmpMarkerRotated,1)
                    for jj = 1:size(tmpMarkerRotated,2)
                        x =  (ii-midx)*cos(tmpBearingRad)+(jj-midy)*sin(tmpBearingRad);
                        y = -(ii-midx)*sin(tmpBearingRad)+(jj-midy)*cos(tmpBearingRad);
                        x = round(x) + midx;
                        y = round(y) + midy;
            
                        if (x>=1 && y>=1 && x<=size(tmpMarkerRotated,2) && y<=size(tmpMarkerRotated,1))
                          tmpMarkerRotated(ii,jj,kk) = marker(x,y,kk);         
                        end
                    end
                end
            end
            
            % Setting color for non-transparent pixel
            tmpMarkerRotated = imresize(tmpMarkerRotated,0.1);
            tmpMarkerRotated(tmpMarkerRotated>0) = 255;
            tmpMarkerRotated(tmpMarkerRotated(:,:,1)>0)=0; % red
            
            % Assignation
            obj.ShipMarker = tmpMarkerRotated;
        end
    end
end

