function [is_inside,coords_component] = gui_isInsidePosition(point,component)
%GUI_CLICKEDINSIDE Determines if point is inside component
%   point:      2 components vector [x,y] in this order
%   component:  appdesigner component

x           = point(1);
y           = point(2);
t_pos       = component.Position(1:2);
t_width     = component.Position(3);
t_height    = component.Position(4);

x_bottom_left_corner    = t_pos(1);
y_bottom_left_corner    = t_pos(2);

x_top_right_corner      = x_bottom_left_corner + t_width;
y_top_right_corner      = y_bottom_left_corner + t_height;

is_inside   = false;

if x >= x_bottom_left_corner && x <= x_top_right_corner && ...
    y >= y_bottom_left_corner && y <= y_top_right_corner
    is_inside = true;
end

% Coordinates in the considered component
coords_component    = zeros(1,2);
coords_component(1) = x - x_bottom_left_corner;
coords_component(2) = y - y_bottom_left_corner;

end

