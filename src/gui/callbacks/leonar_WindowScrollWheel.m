function leonar_WindowScrollWheel(app,event)
%LEONAR_WINDOWSROLLWHEEL Summary of this function goes here
%   Detailed explanation goes here

%% Zoom update
% Extracting wheel count (-1 for wheel down, +1 for wheel up)
wheel_count = event.VerticalScrollCount;

% Updating map current zoom and safeguarding against unavailable zooms
app.mapCurrentZoom = max(min(app.mapCurrentZoom - wheel_count,app.mapMaxZoom),app.mapMinZoom);

%% Updating map
UpdateMapDisplay(app,app.mapCenterCoordinates);

end