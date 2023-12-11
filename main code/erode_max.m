function [outputImage] = erode_max(image,D)
    while length(find(imerode(image, strel('disk', round(0.0033*D))))) > 1 
    image = imerode(image, strel('disk', round(0.0033*D)));
    end 
    outputImage = image; 
end 