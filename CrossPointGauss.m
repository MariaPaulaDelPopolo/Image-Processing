function [crossPoint] = CrossPointGauss(inputImage, nrGauss, guess)

% inputImage = inputImage(inputImage > 0);
crossPoint = guess;
count = 0;
max = 10;

while count < max && crossPoint == guess

    gm = fitgmdist(inputImage(:), nrGauss, 'RegularizationValue', 0.00001, 'Options', statset('MaxIter', 200));
    num_components = gm.NumComponents;
    
    % Initialize variables to store the minimum and second-to-minimum means and their corresponding indices
    index1 = 1;
    index2 = 1;
    
    % Loop through each component and find the two with the lowest means
    for i = 1:num_components
        mu_i = gm.mu(i);
    
        % Check if the current mean is lower than the minimum found so far
        if mu_i < gm.mu(index1)
            index2 = index1;
            index1 = i;
        elseif mu_i < gm.mu(index2)
            % Update the second minimum with the current values
            index2 = i;
        end
    end
    
    mu1 = gm.mu(index1);
    sigma1 = sqrt(gm.Sigma(:,:,index1));
    proportion1 = gm.ComponentProportion(index1);
    mu2 = gm.mu(index2);
    sigma2 = sqrt(gm.Sigma(:,:,index2));
    proportion2 = gm.ComponentProportion(index2);
    
    comp1 = @(x) pdf(gm, mu1) .* proportion1 .* normpdf(x, mu1, sigma1);
    comp2 = @(x) pdf(gm, mu2) .* proportion2 .* normpdf(x, mu2, sigma2);
    diff_function = @(x) (comp1(x) - comp2(x));
    
    
    crossPoint = fzero(diff_function, guess);
    count = count +1;
end

end

