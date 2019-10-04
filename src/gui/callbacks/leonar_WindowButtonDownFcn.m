function [source,coords_source,mouse_source] = leonar_WindowButtonDownFcn(app,event)
%LEONAR_WINDOWBUTTONDOWNFCN Summary of this function goes here
%   Detailed explanation goes here

% Initialization
source = '';

% Current point
current_point = event.Source.CurrentPoint;

% % Checking if we clicked inside the map object
% % Also returns coordinates in the considered object
% [is_inside_map,coords_source] = gui_isInsidePosition(current_point,app.Map);
% if is_inside_map
%     source = 'Map';
% end

% Extracting mouse source
% * normal: simple left click
% * extend: scroll wheel click
% * alt:   right click
% * open: any double click
mouse_source = event.Source.SelectionType;

end