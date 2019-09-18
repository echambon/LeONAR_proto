classdef MapTiled
    %MAPTILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TilesFolder             = ['.' filesep]   	% The folder where tiles are stored
        ZoomLevel               = 14                % Map zoom level
        CenterTile              = Tile;
        MapSize                 = [5 5];            % Number of tiles to store along [height width], make sure these are always odd numbers
        % MapSize depends on the displaying figure size (tiles are 256x256 pixels) + a margin of one tile on each side is taken
    end
    
    properties (Access = private)
        Tiles                   = Tile;           % Map tiles storage
        CenterTileCoordinates   = [3 3];
        VisibleMap              = [];
        DefaultTileCData        = 0*uint8(200*ones(256,256,3)); % Gray tile if missing
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
        
        % TODO: just for debug, to be deleted
        function debugDisplayMap(obj,axHandle)
            imshow(obj.VisibleMap,'Parent',axHandle,'InitialMagnification',100);
%             image(obj.VisibleMap,'Parent',axHandle);
            % TODO : center on given x,y (CenterTile.RefPixel)
            % TODO : only display the pixels visible in the current axes dimensions?
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