close all;
filenames = cellstr(spm_select(Inf, 'image'));

for aa = 1:numel(filenames)
    Y = spm_read_vols(spm_vol(filenames{aa}));
    figure
    histfit(Y(:));
end
