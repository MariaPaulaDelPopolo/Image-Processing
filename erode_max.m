function [outputImage] = erode_max(image,D)
    % while true
    %     temp = imerode(image, strel('disk', round(0.0033*D)));
    %     numPix = length(find(temp)) > 1;
    %     if numPix == 0
    %         break
    %     else
    %         image = temp;
    %     end
    % end
    
    % erode till one more iteration would delete all pixels, stop before that
    while length(find(imerode(image, strel('disk', round(0.0033*D))))) > 1;
    image = imerode(image, strel('disk', round(0.0033*D)));
    end 
    outputImage = image; 
end 