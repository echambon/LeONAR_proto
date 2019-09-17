function [data,ierr] = NMEAparser(line)
%NMEAPARSER NMEA 0183 packet parser
%   ierr =
%       *  0 if no error
%       * -1 if NMEA string is not supported by the parser
%       * -2 if NMEA checksum verification failed

%% Initialization
ierr = 0;
data = struct();

%% Valid and supported NMEA strings
% $GNGGA - Global Positioning System Fix Data
% $GNGLL - Geopgraphic Position - Latitude/Longitude
% $GNGSA - GNSS DOP and Active Satellites
% $GAGSV - GNSS Satellites in View (GALILEO)
% $GBGSV - GNSS Satellites in View (BEIDOU)
% $GLGSV - GNSS Satellites in View (GLONASS)
% $GPGSV - GNSS Satellites in View (GPS)
% $GNRMC - Recommended Minimum Specific GNSS Data
% $GNVTG - Course Over Ground and Ground Speed
NMEA_TYPES = ['$GNGGA'
              '$GNGLL'
              '$GNGSA'
              '$GAGSV'
              '$GBGSV'
              '$GLGSV'
              '$GPGSV'
              '$GNRMC'
              '$GNVTG'];

%% Break NMEA packet fields
fields = textscan(line,'%s','delimiter',',');
% Problem: last field is data+checksum (* separator)
% Checksum is 2 chars long
% Solution:
% 1) copy checksum to new field
fields{1}{end+1} = fields{1}{end}(end-1:end);
% 2) cut off checksum from the last data field
fields{1}{end-1} = strtok(fields{1}{end-1},'*');

%% Detect valid NMEA string
nmea_type = find(strcmp(fields{1}(1),NMEA_TYPES),1);

% Manage the case where NMEA string is not supported by the parser
if isempty(nmea_type)
    ierr = -1;
    return
end

%% Checksum verification
% Calculation
line_checksum = NMEAchecksum(line);

% Comparison
if ~strcmp(line_checksum,fields{1}(end))
    ierr = -2;
end

%% NMEA switch/case
% Convert from cell to char array
fields = char(fields{1});

switch nmea_type
    case 1 % $GNGGA - Global Positioning System Fix Data
        % First data field is the Time of day
        % We store it as a fraction of day (between 0 for 00:00:00 and 1
        % for 23:59:59
        GNGGA_time = fields(2,1:end);
        if isempty(GNGGA_time)
            data.GNGGA.Time = NaN;
        else
            data.GNGGA.Time = datenum(GNGGA_time,'HHMMSS') - floor(datenum(GNGGA_time,'HHMMSS'));
        end
        
        % Second data field is the Latitude
        GNGGA_latitude              = fields(3,1:end);
        GNGGA_latitude_degrees      = str2double(GNGGA_latitude(1:2));
        GNGGA_latitude_minutes      = str2double(GNGGA_latitude(3:end));
        GNGGA_latitude_direction    = fields(4,1); % only one character is useful
        data.GNGGA.Latitude         = GNGGA_latitude_degrees + GNGGA_latitude_minutes/60;
        if strcmp(GNGGA_latitude_direction,'S')
            data.GNGGA.Latitude = -data.GNGGA.Latitude;
        end
        
        % Third data field is the Longitude
        GNGGA_longitude             = fields(5,1:end);
        GNGGA_longitude_degrees     = str2double(GNGGA_longitude(1:3));
        GNGGA_longitude_minutes     = str2double(GNGGA_longitude(4:end));
        GNGGA_longitude_direction   = fields(6,1); % only one character is useful
        data.GNGGA.Longitude        = GNGGA_longitude_degrees + GNGGA_longitude_minutes/60;
        if strcmp(GNGGA_longitude_direction,'W')
            data.GNGGA.Longitude = -data.GNGGA.Longitude;
        end
        
        % Fix quality
        GNGGA_fix_quality = fields(7,1:end);
        data.GNGGA.Fix = str2double(GNGGA_fix_quality);
        % 0 : none
        % 1 : GPS fix
        % 2 : DGPS fix
        
        % Number of satellites
        GNGGA_satellites = fields(8,1:end);
        data.GNGGA.Satellites = str2double(GNGGA_satellites);
        
        % HDOP
        GNGGA_HDOP = fields(9,1:end);
        if ~isempty(GNGGA_HDOP)
            data.GNGGA.HDOP = str2double(GNGGA_HDOP);
        end
        
        % Altitude
        GNGGA_altitude      = fields(10,1:end);
        if ~isempty(GNGGA_altitude)
            data.GNGGA.Altitude = str2double(GNGGA_altitude);
        end
        
        line
        data.GNGGA
        
    case 2 % $GNGLL - Geopgraphic Position - Latitude/Longitude
%         fields
%         disp('not implemented');
        
    case 3 % GNSS DOP and Active Satellites
%         fields
%         disp('not implemented');
end

end

