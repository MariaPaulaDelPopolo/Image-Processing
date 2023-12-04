function [outputImage] = erode_condition(image)
    while length(find(imerode(image, strel('disk', 1)))) > 3000 
    image = imerode(image, strel('disk', 1));
    end 
    outputImage = image; 
end 