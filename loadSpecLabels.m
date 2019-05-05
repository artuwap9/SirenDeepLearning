function labels = loadSpecLabels()
    images = [pwd,'/images/new_all/'];
    jpgfiles = dir(fullfile(images,'*.jpg*'));
    n = numel(jpgfiles);
    for i = 1:n
        name = jpgfiles(i).name;
        labels(i) = str2double(name(length(name)-4));
    end
end