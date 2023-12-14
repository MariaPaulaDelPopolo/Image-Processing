function [D] = Diagonal(image)
% DIAGONALFACTOR - Calculate the diagonal factor of an image.
%
%   Input:
%   - image: Input image.
%
%   Output:
%   - D: Diagonal factor of the input image.
%
%   Description:
%   This function calculates the diagonal of the input image
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

[L, B] = size(image); % get size
D = sqrt(L*L + B*B); % calculate diagonal

end

