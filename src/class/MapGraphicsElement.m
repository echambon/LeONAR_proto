classdef MapGraphicsElement
    %MAPELEMENT Graphical element to diaply on map
    %   Detailed explanation goes here
    
    properties
        Image                   % image matrix (R,G,B array)
        Position    = [1 1]     % position of top left pixel in the map
        Rotated     = 0
        Resized     = 1
    end
    
    methods
        function obj = MapGraphicsElement(image,position)
            obj.Image       = image;
            obj.Position    = position;
        end
        
        function obj = Rotate(obj,angle) % angle in degrees
            tmpImage        = obj.Image;
            tmpImageRotated = uint8(zeros(size(obj.Image)));
            
            midx = floor(size(tmpImageRotated,2)/2);
            midy = floor(size(tmpImageRotated,1)/2);
            tmpAngleRad = deg2rad(angle);
            
            for kk = 1:size(tmpImageRotated,3)
                for ii = 1:size(tmpImageRotated,1)
                    for jj = 1:size(tmpImageRotated,2)
                        x =  (ii-midx)*cos(tmpAngleRad)+(jj-midy)*sin(tmpAngleRad);
                        y = -(ii-midx)*sin(tmpAngleRad)+(jj-midy)*cos(tmpAngleRad);
                        x = round(x) + midx;
                        y = round(y) + midy;
            
                        if (x>=1 && y>=1 && x<=size(tmpImageRotated,2) && y<=size(tmpImageRotated,1))
                          tmpImageRotated(ii,jj,kk) = tmpImage(x,y,kk);         
                        end
                    end
                end
            end
            
            obj.Image   = tmpImageRotated;
            obj.Rotated = obj.Rotated + angle;
        end
        
        function obj = Resize(obj,scale)
             obj.Image      = imresize(obj.Image,scale,'nearest');
             obj.Resized    = obj.Resized*scale;
        end
    end
end

