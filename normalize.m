function [normalizedImage] = normalize(image)

normalizedImage = double(image) / double(max(image(:)));

end

