function leonar_MapImageFakeCallbacks(obj, eventData, hWin)
%LEONAR_WINDOWBUTTONDOWNFCN Summary of this function goes here
%   Detailed explanation goes here

% Retrieve and decode payload JSON:
payload = jsondecode(hWin.executeJS('payload'));

% Current point
current_point = payload.coord;

% Mouse action
mouse_action = payload.action;

% Debug
% TODO: improve code readability (do not use indices ...)
obj.Parent.Children(2).Children(2).Text     = num2str([current_point(1) current_point(2)]);
obj.Parent.Children(2).Children(1).Text 	= mouse_action;

end