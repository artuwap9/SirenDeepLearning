function Testing(Imgs, Lbs, F, W1, W2)

Images = Imgs(:, :, 8001:10000);
Labels = Lbs(8001:10000);
acc = 0;
N   = length(Labels);
for k = 1:N
  X = Images(:, :, k);              
  i = TestSpecCNN(X, F, W1, W2);
  if i == Labels(k)
    acc = acc + 1;
  end
end
acc = acc / N;
fprintf('Accuracy is %f\n', acc);
end