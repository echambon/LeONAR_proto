function wheel_count = leonar_WindowScrollWheel(~,event)
%LEONAR_WINDOWSROLLWHEEL Summary of this function goes here
%   Detailed explanation goes here

% Extracting wheel count (-1 for wheel down, +1 for wheel up)
wheel_count = event.VerticalScrollCount;

end

