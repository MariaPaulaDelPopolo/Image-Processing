function [image_out] = conditional_dilation(image_in, template_image, structure_element, iterate)

template_image_2 = imcomplement(template_image);

k = 0;

while k < iterate
    
    image_temp = imdilate(image_in, structure_element);

    for i = 1:1:size(image_in,1)
       
        for j = 1:1:size(image_in, 2)

             if image_temp(i,j) == 1 && template_image_2(i,j) == 1

                 image_temp(i,j) = 0;

            end
       
        end
   
    end

    image_in = image_temp;
    
    k = k + 1;

end
    


image_out = image_temp;

end