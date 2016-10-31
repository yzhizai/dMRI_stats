filename = spm_select(1, 'image');
Y = spm_read_vols(spm_vol(filename));

Y_hist = Y(:);
Y_hist(isnan(Y_hist)| Y_hist > 20) = [];

figure
histfit(Y_hist, 50, 'exponential');