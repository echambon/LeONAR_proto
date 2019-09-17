function ErrorIfPointNotInSquare(point,xy_min,xy_max,message)
%ERRORIFNOTINRECTANGLE Summary of this function goes here
%   Detailed explanation goes here

if point(1) < xy_min || point(1) > xy_max || point(2) < xy_min || point(2) > xy_max
    error(message);
end

end

