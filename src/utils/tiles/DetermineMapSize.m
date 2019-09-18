function MapSize = DetermineMapSize(width,height)
%DETERMINEMAPSIZE Summary of this function goes here
%   Detailed explanation goes here

% Determining number of lines and columns
n_lines     = ceil(height/256);
n_columns   = ceil(width/256);

% Ensuring numbers are odd and adding margin
if ~mod(n_lines,2)
    n_lines = n_lines + 1;
else
    n_lines = n_lines + 2; % margin
end
if ~mod(n_columns,2)
    n_columns = n_columns + 1;
else
    n_columns = n_columns + 2; % margin
end

% Output
MapSize = [n_lines n_columns];

end

