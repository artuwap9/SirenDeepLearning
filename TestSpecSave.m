function X = TestSpecSave(jpgfiles)
    saveas(gcf,[pwd,'/0_spec','.jpg']);
    im = jpgfiles.name;
    imRGB = imread(fullfile(pwd,im));
    X = rgb2gray(imRGB);
    img = uint8(X);
    K = imadjust(img,[0.4 .6],[]);
    X = double(K);
    X(135:167,:) = [];
    X(:, 1:33) = [];
    X = X/255;
end