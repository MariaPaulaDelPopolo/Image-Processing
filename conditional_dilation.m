function [image_out] = conditional_dilation(image_in, template_image, structure_element,condition)
% CONDITIONAL_DILATION - Perform conditional dilation on the input image.
%
%   Input:
%   - image_in: Input binary image for dilation.
%   - template_image: Template for element-wise multiplication after each dilation.
%   - structure_element: Structuring element for dilation.
%   - condition: Condition to terminate dilation (difference in white pixel count).
%
%   Output:
%   - image_out: Resultant image after conditional dilation.
%
%   Description:
%   This function performs conditional dilation on the input binary image. It
%   iteratively applies dilation using the specified structuring element and
%   terminates when the condition (change in the number of white pixels) is met.
% 
%   Authors:
%   Roos Meijer, Paula Del Popolo, Ellen van Hulst, Erik van Riel.
%   
%   Date of Submission:
%   December 14, 2023

% Preform dilation until condition is met
image_temp1 = image_in; 
image_temp2 = imdilate(image_in, structure_element);
image_temp2 = image_temp2.*template_image; 
    while length(find(image_temp2 ==1))-length(find(image_temp1 ==1))>condition
    image_temp1 = image_temp2; 
    image_temp2 = imdilate(image_temp2, structure_element);
    image_temp2 = image_temp2.*template_image; 
    end 
image_out = image_temp2;

end