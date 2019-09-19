function leonar_WindowButtonMotion(app,event)
%LEONAR_WINDOWSROLLWHEEL Summary of this function goes here
%   Detailed explanation goes here

if app.mapClicked
    app.mapMotionCounter = app.mapMotionCounter + 1;
    disp(app.mapMotionCounter);
end

end