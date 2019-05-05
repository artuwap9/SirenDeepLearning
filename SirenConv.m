function [F, W1, W2] = SirenConv(F, W1, W2, Images, Labels)

    alpha = 0.01;
    beta  = 0.95;
    mmtmF = zeros(size(F));
    mmtm1 = zeros(size(W1));
    mmtm2 = zeros(size(W2));
    N = length(Labels);
    bsize = 100;
    blist = 1:bsize:(N-bsize+1);
    
    % Epoch loop
    for batch = 1:length(blist)
       dWF = zeros(size(F));     
       dW1 = zeros(size(W1));     
       dW2 = zeros(size(W2));     
       
       % Mini-batch loop
       begin = blist(batch);
       for k = begin:begin+bsize-1
        
         % Neural Network
         img  = Images(:, :, k);        % Spectrogram          First Layer
         c1 = Conv(img, F);             % Filter Convolution  Second Layer       
         c2 = ReLU(c1);                 %                      Third Layer
         c3 = Pool(c2);                 % Pool                Fourth Layer
         n1 = reshape(c3, [], 1);       %
         n2 = W1*n1;                    %
         n3 = ReLU(n2);                 % ReLU
         n4 = W2*n3;                    %
         out= Softmax(n4);              % Softmax
         d  = zeros(5, 1);
         d(sub2ind(size(d), Labels(k), 1)) = 1;
        
         % Backpropagation
         e      = d - out;              % Delta Rule (d = correct output,
         delta2 = e;                    % y = output from network) 
                                        % Output Layer
         eW2 = W2' * delta2;            % Hidden(ReLU) layer
         delta1 = (n3 > 0) .* eW2;   
         eW1 = W1' * delta1;            % Pooling layer
         e3  = reshape(eW1, size(c3)); 
         e2  = zeros(size(c2));
         W3  = ones(size(c2)) / (2*2);
         for c = 1:20
           e2(:, :, c) = kron(e3(:, :, c), ones([2 2])) .* W3(:, :, c);
         end
         deltaR = (c2 > 0) .* e2;       % ReLU layer
         deltaF = zeros(size(F));       % Convolutional layer
         for c = 1:20
           deltaF(:, :, c) = conv2(img(:, :), rot90(deltaR(:, :, c), 2),'valid');
         end
         dWF = dWF + deltaF;
         dW1 = dW1 + delta1*n1';
         dW2 = dW2 + delta2*n3';
       end
      
      % Update weights
      dWF = dWF / bsize;  
      dW1 = dW1 / bsize;
      dW2 = dW2 / bsize;
      mmtmF = alpha*dWF + beta*mmtmF; 
      F   = F + mmtmF;               
      mmtm1 = alpha*dW1 + beta*mmtm1;
      W1  = W1 + mmtm1;
      mmtm2 = alpha*dW2 + beta*mmtm2;
      W2  = W2 + mmtm2;
     end
end