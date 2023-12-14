function [normalizedImage] = normalize(image)
% NORMALIZE - Normalize the intensity values of an image.
%
%   Input:
%   - image: Input image with intensity values to be normalized.
%
%   Output:
%   - normalizedImage: Image with intensity values normalized to the range [0, 1].
%
%   Description:
%   This function normalizes the intensity values of the input image by
%   dividing each pixel value by the maximum intensity value in the image.
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023


normalizedImage = double(image) / double(max(image(:)));

end