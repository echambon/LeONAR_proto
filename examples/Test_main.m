clear; close all;

% Adding LeONAR src to the path
addpath('D:\GitHub\LeONAR_proto\src');

% Executing LeONAR
main();

%% Debug marker
[marker,~,~]  = imread('marker.png');
maptile = imread('D:\GitHub\LeONAR_dev\tiles\7\63\42.png');

% Rotate marker
theta = -45;
markerRotated=zeros(size(marker)); % midx and midy same for both

midx = floor(size(markerRotated,2)/2);
midy = floor(size(markerRotated,1)/2);
rads = deg2rad(theta);

for kk = 1:size(markerRotated,3)
    for ii = 1:size(markerRotated,1)
        for jj = 1:size(markerRotated,2)

            x =  (ii-midx)*cos(rads)+(jj-midy)*sin(rads);
            y = -(ii-midx)*sin(rads)+(jj-midy)*cos(rads);
            x = round(x) + midx;
            y = round(y) + midy;

            if (x>=1 && y>=1 && x<=size(markerRotated,2) && y<=size(markerRotated,1))
              markerRotated(ii,jj,kk) = marker(x,y,kk); % k degrees rotated image         
            end

        end
    end
end

markerRotated = uint16(imresize(markerRotated,0.1));
markerRotated(markerRotated>0) = 255;
markerRotated(markerRotated(:,:,1)>0)=0; % red
markerPosition = [100 100];
markerSize = size(markerRotated);

result = uint16(maptile);
result(markerPosition(1):markerPosition(1)+markerSize(1)-1,markerPosition(2):markerPosition(2)+markerSize(2)-1,:) = ...
    result(markerPosition(1):markerPosition(1)+markerSize(1)-1,markerPosition(2):markerPosition(2)+markerSize(2)-1,:) + markerRotated;
result(result>255) = 0;
result = uint8(result);

imshow(result);