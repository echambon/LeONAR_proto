function wheel_count = leonar_WindowScrollWheel(app,event)
%LEONAR_WINDOWSROLLWHEEL Summary of this function goes here
%   Detailed explanation goes here

% Extracting wheel count (-1 for wheel down, +1 for wheel up)
wheel_count = event.VerticalScrollCount;

% Updating map current zoom and safeguarding against unavailable zooms
app.mapCurrentZoom = max(min(app.mapCurrentZoom - app.cbMouseWheelCount,app.mapMaxZoom),app.mapMinZoom);

%% Debug
app.DebugLabel.Text = num2str(app.mapCurrentZoom);

end

