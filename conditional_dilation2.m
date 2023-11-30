function [image_out] = conditional_dilation(image_in, template_image, structure_element,condition)
    image_temp1 = image_in; 
    image_temp2 = imdilate(image_in, structure_element);
    image_temp2 = image_temp2.*template_image; 
        while length(find(image_temp2 ==1))-length(find(image_temp1 ==1))>condition
        hoi =  length(find(image_temp2 ==1))-length(find(image_temp1 ==1))
        image_temp1 = image_temp2; 
        image_temp2 = imdilate(image_temp2, structure_element);
        image_temp2 = image_temp2.*template_image; 
        % figure(7)
        % imshow(image_temp1)
        % figure(8)
        % imshow(image_temp2)
        end 
    image_out = image_temp2
end