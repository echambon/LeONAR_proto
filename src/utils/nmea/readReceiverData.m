function readReceiverData(src,~)
%READRECEIVERDATA Summary of this function goes here
%   Detailed explanation goes here

% Read the ASCII data from the serialport object.
data = readline(src);

% Convert to string
data = num2str(data);

% dataLength = length(data);
% % Store data
% src.UserData.Data(src.UserData.Count,1:dataLength) = data;

% Update the Count value of the serialport object.
src.UserData.Count = src.UserData.Count + 1;

% Display data
NMEAparser(data);

%
% flush(src);

% Escape callback when count > some value
% if src.UserData.Count > 1
%     configureCallback(src, "off");
% end

end

