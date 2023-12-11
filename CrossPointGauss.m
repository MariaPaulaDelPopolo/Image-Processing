function [crossPoint] = CrossPointGauss(inputImage, nrGauss, guess)

% inputImage = inputImage(inputImage > 0);

gm = fitgmdist(inputImage(:), nrGauss, 'RegularizationValue', 0.00001);
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

%% To Display the gaussian plots

% x = linspace(min(inputImage(:)), max(inputImage(:)), 1000);
% 
% figure;
% plot(x, pdf(gm, x'), "LineWidth", 2); % how to do this correctly?
% histogram(inputImage(:), 'Normalization', 'pdf');
% hold on;
% 
% plot(x, comp1(x), 'LineWidth', 2);
% plot(x, comp2(x), 'LineWidth', 2);
% plot(crossPoint, comp1(crossPoint), 'ro', 'MarkerSize', 10);

% Scale and multiply by histogram values
% binEdges = hist.BinEdges;
% 
% binIndex1 = 1;
% binIndex2 = 1;
% 
% for i = 1:length(binEdges)
%     if mu1 > binEdges(i)
%         binIndex1 = i;
%     end
%     if mu2 > binEdges(i)
%         binIndex2 = i;
%     end
% end
% 
% scaled_comp1 = @(x) comp1(x) / max(comp1(x)) * hist.Values(binIndex1) * 1.1;
% scaled_comp2 = @(x) comp2(x) / max(comp2(x)) * hist.Values(binIndex2) * 1.1;
% 
% plot(x, scaled_comp1(x), 'LineWidth', 2);
% plot(x, scaled_comp2(x), 'LineWidth', 2);
% 
% xline(crossPoint-0.0095, 'r--', 'LineWidth', 2);
% plot(crossPoint-0.0095, comp1(crossPoint-0.0095)/max(comp1(x)) * hist.Values(binIndex1) * 1.1 , 'ro', 'MarkerSize', 5);

% hold off;

% figure(3);
% histogram(inputImage);

end

