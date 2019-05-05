function i = TestSpecCNN(X, F, W1, W2)
    x = X;                          % Input,         134x134
    c1 = Conv(x, F);                % Convolution
    c2 = ReLU(c1);                  % ReLU 
    c3 = Pool(c2);                  % Pool 
    c4 = reshape(c3, [], 1);        % New Input After Convolution Layers
    n1 = W1*c4;                     % 1st Weight   
    n2 = ReLU(n1);                  % ReLU (Hidden Layer)
    n3  = W2*n2;                    % 2nd Weight              
    y  = Softmax(n3);               % Softmax (Output Layer) 
    [~, i] = max(y);                % Output
end