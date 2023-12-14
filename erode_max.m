function [outputImage] = erode_max(image,D)
% ERODE_MAX - Perform erosion on the input image until one more iteration
%              would delete all pixels, then stop.
%
%   Input:
%   - image: Binary input image for erosion.
%   - D: Diagonal, for stopping criterion.
%
%   Output:
%   - outputImage: Resultant image after erosion.
%
%   Description:
%   This function performs erosion on the input binary image iteratively
%   using a disk-shaped structuring element of radius 1. It stops when one
%   more iteration would delete all pixels, ensuring a minimal erosion
%   while retaining connectivity.
%
%   See also: Diagonal
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

while true
    temp = imerode(image, strel('disk', 1));
    numPix = length(find(temp)) > 1;
    if numPix == 0
        break
    else
        image = temp;
    end
end
outputImage = image; 
end 