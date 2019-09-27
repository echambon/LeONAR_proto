classdef Tile
    %TILE Class to store Tile information
    %   Detailed explanation goes here
    
    properties
        Column   = 1
        Line     = 1   
        RefPixel = [1 1] % A specifically referenced pixel, by default: top left pixel
    end
    
    methods
        % Equality operator redefinition
        % /!\ obj1 may be an array of Tile, obj2 may not
        function tf = eq(obj1,obj2)
            tf = false(size(obj1));
            
            for ii = 1:size(obj1,1)
                for jj = 1:size(obj1,2)
                    if all(obj1(ii,jj).RefPixel == obj2.RefPixel) && obj1(ii,jj).Column == obj2.Column && obj1(ii,jj).Line == obj2.Line
                        tf(ii,jj) = true;
                    end
                end
            end
        end
    end
    
end

