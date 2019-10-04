function leonar_MapImageFakeCallbacks(hWin, app)
%LEONAR_WINDOWBUTTONDOWNFCN Summary of this function goes here
%   Detailed explanation goes here

% Retrieve and decode payload JSON:
payload = jsondecode(hWin.executeJS('payload'));

% Current point
current_point = payload.coord;

% Mouse action
mouse_action = payload.action;

% Debug
app.DebugLabelPosition.Text	= num2str([current_point(1) current_point(2)]);
app.DebugLabelMouse.Text	= mouse_action;

end