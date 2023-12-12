function [image_out] = conditional_dilation(image_in, template_image, structure_element,condition)

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