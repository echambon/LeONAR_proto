function leonar_WindowButtonMotion(app,event)
%LEONAR_WINDOWSROLLWHEEL Summary of this function goes here
%   Detailed explanation goes here

if app.mapClicked && strcmp(app.mapMouseSource,'normal') % left click
    tmpPreviousIntersectionPoint   = app.mapFigureIntersectionPoint;
    
    % Updating motion counter
    app.mapMotionCounter(1) = app.mapMotionCounter(1) + sign(event.IntersectionPoint(1) - tmpPreviousIntersectionPoint(1));
    app.mapMotionCounter(2) = app.mapMotionCounter(2) + sign(event.IntersectionPoint(2) - tmpPreviousIntersectionPoint(2));
    
    % Debug
    app.DebugLabel.Text = [num2str(app.mapMotionCounter(1)) ' - ' num2str(app.mapMotionCounter(2))];
    
    % Update previous intersection point
    app.mapFigureIntersectionPoint = event.IntersectionPoint;
end

end