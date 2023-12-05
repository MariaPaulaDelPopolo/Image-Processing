function [minimum, num_components] = LocalMinimum(inputImage, nrGauss, guess)

inputImage = inputImage(inputImage > 0);

gm = fitgmdist(inputImage(:), nrGauss); %, 'RegularizationValue', 0.001);
num_components = gm.NumComponents;

% Initialize variables to store the minimum and second-to-minimum means and their corresponding indices
min_mu = inf;
second_min_mu = inf;
min_sigma = [];
second_min_sigma = [];

% Loop through each component and find the two with the lowest means
for i = 1:num_components
    mu_i = gm.mu(i);
    sigma_i = sqrt(gm.Sigma(:,:,i));  % Taking the square root to get standard deviation
    
    % Check if the current mean is lower than the minimum found so far
    if mu_i < min_mu
        % Move the current minimum to second minimum
        second_min_mu = min_mu;
        second_min_sigma = min_sigma;
        
        % Update the minimum with the current values
        min_mu = mu_i;
        min_sigma = sigma_i;
    elseif mu_i < second_min_mu
        % Update the second minimum with the current values
        second_min_mu = mu_i;
        second_min_sigma = sigma_i;
    end
end

diff_function = @(x) (pdf(gm, min_mu)* normpdf(x, min_mu, min_sigma)) - (pdf(gm, second_min_mu) * normpdf(x, second_min_mu, second_min_sigma));

minimum = fzero(diff_function, guess);

% To Display the gaussian plots

x = linspace(min(inputImage(:)), max(inputImage(:)), 1000);

sumPDF = zeros(size(x));

% Calculate and accumulate the PDFs
for i = 1:gm.NumComponents
    y = pdf(gm, x');
    sumPDF = sumPDF + y;
end

% figure(2);
% % subplot(3, 5, k);
% plot(x, sumPDF, 'LineWidth', 2);
% hold on;
% plot(minimum, interp1(x, sumPDF, minimum), 'ro', 'MarkerSize', 10);
% hold off;
% 
% figure(3);
% histogram(inputImage);

end

