function line_checksum = NMEAchecksum(line)
%NEMACHECKSUM Calculates checksum of NMEA line packet
%   Detailed explanation goes here

% Initialization
line_checksum = uint8(0);

% Checksum calculation
% The leading '$' and lasting checksum (past *) are not considered
for i_char = 2:(find(line=='*',1,'last')-1)
    line_checksum = bitxor(line_checksum, uint8(line(i_char))); 
end
line_checksum = dec2hex(line_checksum, 2);

end

