function [outputImage] = erode_max(image,D)
% erode till one more iteration would delete all pixels, stop before that    
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