classdef MapTiled
    %MAPTILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TilesFolder             = ['.' filesep]   	% The folder where tiles are stored
        ZoomLevel               = 14                % Map zoom level
        CenterTile              = Tile;
        MapSize                 = [5 5];            % Number of tiles to store along [height width], make sure these are always odd numbers
        % MapSize depends on the displaying figure size (tiles are 256x256 pixels) + a margin of one tile on each side is taken
        Tiles                   = Tile;           % Map tiles storage
        InteractiveMap          = [];
        VisibleMap              = [];
    end
    
    properties (Access = private)
        CenterTileCoordinates   = [3 3];
        DefaultTileCData        = uint8(200*ones(256,256,3)); % Gray tile if missing
    end
    
    methods
        function obj = MapTiled(TilesFolder,ZoomLevel,CenterTile,MapSize)
            obj.TilesFolder                                 = TilesFolder;
            obj.ZoomLevel                                   = ZoomLevel;
            obj.CenterTile                                  = CenterTile;
            obj.MapSize                                     = MapSize;
            
            obj.Tiles(1:obj.MapSize(1),1:obj.MapSize(2))    = Tile;
            obj.CenterTileCoordinates                       = ceil(obj.MapSize./2);
            
            obj = obj.updateMapTiles;
            obj = obj.buildVisibleMap;
        end
        
        function obj = DisplayMap(obj,axHandle,interactiveElements)            
            % Update pixels to display
            [obj,displayedHeightPixels,displayedWidthPixels] = GetPixelsToDisplay(obj,axHandle);
            
            % Add interactive elements (marker, etc.) to the visible map
            listInteractiveElements = fieldnames(interactiveElements);
            for iElement = 1:length(listInteractiveElements)
                obj = obj.addToVisibleMap(interactiveElements.(listInteractiveElements{iElement}).GraphicsElement,iElement);
            end
            
            % Showing map
            axHandle.ImageSource = obj.VisibleMap(displayedHeightPixels,displayedWidthPixels,:);
        end
        
        function [obj,displayedHeightPixels,displayedWidthPixels] = GetPixelsToDisplay(obj,axHandle)            
            % obj.VisibleMap is of size [height_pixels width_pixels]
            % axHandle.Position is of size [_ _ width height]            
            % Axes position
            axHeight    = axHandle.Position(4);
            axWidth     = axHandle.Position(3);
            
            % Build around CenterTile.RefPixel
            ctRefPixelX = (obj.CenterTileCoordinates(1)-1)*256 + obj.CenterTile.RefPixel(2);
            ctRefPixelY = (obj.CenterTileCoordinates(2)-1)*256 + obj.CenterTile.RefPixel(1);
            
            % To ensure displayed height and width are coherent with axes height and width
            displayedHeightPixels = (ctRefPixelX-floor(axHeight/2)):(ctRefPixelX-floor(axHeight/2))+axHeight-1;
            displayedWidthPixels  = (ctRefPixelY-floor(axWidth/2)):(ctRefPixelY-floor(axWidth/2))+axWidth-1;
        end
    end
    
    methods (Access = private)
        function obj = updateMapTiles(obj)
            % Center tile coordinates in the map Tiles array
            x_ct = obj.CenterTileCoordinates(1);
            y_ct = obj.CenterTileCoordinates(2);
            
            % From center tile, derive other tiles coordinates
            for ii = 1:obj.MapSize(1)
                for jj = 1:obj.MapSize(2)
                    if ii == x_ct && jj == y_ct
                        % Update center tile
                        obj.Tiles(ii,jj) = obj.CenterTile;
                    else
                        % Update other tiles Line and Column
                        obj.Tiles(ii,jj).Line   = obj.CenterTile.Line   + (ii-x_ct);
                        obj.Tiles(ii,jj).Column = obj.CenterTile.Column + (jj-y_ct);
                    end
                end
            end
        end
        
        function obj = addToVisibleMap(obj,element,id)
            elementSize = size(element.Image);

            % Assign temporary visible & interactive maps
            tmpVisibleMap       = obj.VisibleMap;
            tmpInteractiveMap   = obj.InteractiveMap;

            % Update pixel by pixel
            for ii = 1:elementSize(1)
                for jj = 1:elementSize(2)
                    if any(element.Image(ii,jj,:) > 0) % pixel is not blank (=transparent)
                        tmpVisibleMap(element.Position(1)+ii,element.Position(2)+jj,:)      = element.Image(ii,jj,:);
                        tmpInteractiveMap(element.Position(1)+ii,element.Position(2)+jj) 	= id;
                    end
                end
            end

            % Assign new visible & interactive maps
            obj.VisibleMap      = tmpVisibleMap;
            obj.InteractiveMap  = tmpInteractiveMap;
        end
        
        function obj = buildVisibleMap(obj)            
            tilesPaths = obj.getTilesPath;

            kk = 1;
            obj.VisibleMap = [];
            for ii = 1:obj.MapSize(1)
                tmp.(['line' num2str(ii)]) = [];
                for jj = 1:obj.MapSize(2)
                    try % manage missing tile bug
                        im = imread(tilesPaths{ii,jj});
                    catch
                        im = obj.DefaultTileCData;
                    end
                    tmp.(['im' num2str(kk)]) = im;
                    tmp.(['line' num2str(ii)]) = [tmp.(['line' num2str(ii)]) tmp.(['im' num2str(kk)])];
                    kk = kk + 1;
                end
                obj.VisibleMap = [obj.VisibleMap;tmp.(['line' num2str(ii)])];
            end
            
            % Also build interactive map
            obj.InteractiveMap = zeros(size(obj.VisibleMap,1:2));
        end
        
        function TilesPath = getTilesPath(obj)
            for ii = 1:obj.MapSize(1)
                for jj = 1:obj.MapSize(2)
                    TilesPath{ii,jj} = obj.getTilePath(obj.Tiles(ii,jj)); %#ok<AGROW>
                end
            end
        end
        
        function TilePath = getTilePath(obj,Tile)
            t_TilesFolder = obj.TilesFolder;
            if ~strcmp(t_TilesFolder(end),filesep)
                t_TilesFolder = [t_TilesFolder filesep];
            end
            TilePath = [t_TilesFolder num2str(obj.ZoomLevel) filesep num2str(Tile.Column) filesep num2str(Tile.Line) '.png'];
        end
    end
    
end