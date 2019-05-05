function [labels, images] = loadSpecs()
    imagesPath = [pwd,'/images/new_all/'];
    jpgfiles = dir(fullfile(imagesPath,'*.jpg*'));
    n = numel(jpgfiles);
    images = [];
    for i = 1:n
        name = jpgfiles(i).name;
        imRGB = imread(fullfile(imagesPath,name));
        images(:,:,i) = rgb2gray(imRGB);
        img = uint8(images(:,:,i));
        K(:,:,i) = imadjust(img,[0.4 .6],[]);
        images = double(K);
        labels(i) = str2double(name(length(name)-4));
    end
    images(135:167, :, :) = [];             % Get rid of white space
    images(:, 1:33, :) = [];                %
    images = images/255;                    % Pixel values from 0 to 1
end