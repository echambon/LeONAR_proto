function leonar_MapImageFakeCallbacks(hWin, app)
%LEONAR_WINDOWBUTTONDOWNFCN Summary of this function goes here
%   Detailed explanation goes here

% Retrieve and decode payload JSON:
payload = jsondecode(hWin.executeJS('payload'));

% Current point
current_point = payload.coord;

% Mouse action
mouse_action = payload.action;

% Update clicked status
switch mouse_action
    case 'leftclick'
        app.mapClicked = true;
        [~,displayedHeightPixels,displayedWidthPixels] = app.mapTiles.GetPixelsToDisplay(app.Map);
        tmpInteractiveMap = app.mapTiles.InteractiveMap(displayedHeightPixels,displayedWidthPixels);
        tmpInteractiveMap(current_point(2),current_point(1)) % TODO: a little problem (seems to be moved problem of uiimage position ?)
    case 'mouseup'
        app.mapClicked = false;
end

% Debug
app.DebugLabelPosition.Text	= num2str([current_point(1) current_point(2)]);
app.DebugLabelMouse.Text	= mouse_action;
app.DebugLabelClicked.Text  = num2str(app.mapClicked);

end