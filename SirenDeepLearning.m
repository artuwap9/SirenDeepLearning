clear all
tic
% Load Spectrograms
[Lbs, Imgs] = loadSpecs();
rng(1);

% Generate Weights
F = 1e-2*randn([9 9 20]);                                  % 20 9 x 9 convolution layers (filters)
W1 = (2*rand(100, 79380) - 1) * sqrt(6) / sqrt(360 + 79380);   % First Weight with 79380 nodes 
                                                           % (after convolution filters) connecting 
                                                           % to 100 nodes (hidden Layer)
W2 = (2*rand( 5,  100) - 1) * sqrt(6) / sqrt( 5 +  100);   % Second Weight with 100 nodes, 5 outputs
Images = Imgs(:, :, 1:8000);
Labels = Lbs(1:8000);

% Machine Learning (CNN)
for epoch = 1:3
  epoch;
  [F, W1, W2] = SirenConv(F, W1, W2, Images, Labels);
end
save('SirenConv.mat', 'F', 'W1', 'W2', '-v7.3');          % Convolution Neural Network

% Testing 
Testings(Imgs, Lbs, F, W1, W2);
toc