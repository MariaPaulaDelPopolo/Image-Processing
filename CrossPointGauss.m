function [crossPoint] = CrossPointGauss(inputImage, nrGauss, guess)

% initialize variables
crossPoint = guess;
count = 0;
max = 10;

% fit gaussian curves on the histogram, repeat if crosspoint is exactly the
% guess value (this is most likely a fail). repeat max 10 times.
while count < max && crossPoint == guess

    gm = fitgmdist(inputImage(:), nrGauss, 'RegularizationValue', 0.00001, 'Options', statset('MaxIter', 200));
    num_components = gm.NumComponents;
    
    % Initialize variables
    index1 = 1;
    index2 = 1;
    
    % Loop through each component and find the two with the lowest means
    for i = 1:num_components
        mu_i = gm.mu(i);

        % updating the varaiables if necessary
        if mu_i < gm.mu(index1)
            index2 = index1;
            index1 = i;
        elseif mu_i < gm.mu(index2)
            index2 = i;
        end
    end
    
    % assigning mu and sigma
    mu1 = gm.mu(index1);
    sigma1 = sqrt(gm.Sigma(:,:,index1));
    proportion1 = gm.ComponentProportion(index1);
    mu2 = gm.mu(index2);
    sigma2 = sqrt(gm.Sigma(:,:,index2));
    proportion2 = gm.ComponentProportion(index2);
    
    % Get components
    comp1 = @(x) pdf(gm, mu1) .* proportion1 .* normpdf(x, mu1, sigma1);
    comp2 = @(x) pdf(gm, mu2) .* proportion2 .* normpdf(x, mu2, sigma2);
    diff_function = @(x) (comp1(x) - comp2(x));
    
    %Caluclate crosspoint
    crossPoint = fzero(diff_function, guess);
    count = count +1;
end

end

