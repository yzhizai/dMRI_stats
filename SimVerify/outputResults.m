function meanVal = outputResults

filenames = cellstr(spm_select(Inf, 'image', 'choose the T2 files..'));

meanVal = cellfun(@readFile2mean, filenames);

return

function meanVal = readFile2mean(filename)

Y = spm_read_vols(spm_vol(filename));
Y(isnan(Y)) = 0;

Y_num = Y > 0;
meanVal = sum(Y(:))/sum(Y_num(:));