function [outputImage] = erode_max(image)
    while length(find(imerode(image, strel('disk', 1)))) > 1 
    image = imerode(image, strel('disk', 1));
    end 
    outputImage = image; 
end 