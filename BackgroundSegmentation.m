function [outputImage] = BackgroundSegmentation(image)
% BACKGROUNDSEGMENTATION - Perform background segmentation on the input image.
%
%   Input:
%   - image: Input greyscale image.
%
%   Output:
%   - outputImage: Binary mask representing the segmented background.
%
%   Description:
%   This function performs background segmentation on the input greyscale image.
%   It uses a thresholding technique and morphological operations to create a
%   binary mask isolating the background.
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

D = Diagonal(image); % Diagonal of the image

% Threshold to get everything but the background
threshold = graythresh(image)/2;
maskImage = image > threshold;

% Close the gaps, strel based on diameter
maskImage = imclose(maskImage,strel('disk', round(0.05*D))); 
maskImage = imcomplement(maskImage);

outputImage = maskImage;

end

