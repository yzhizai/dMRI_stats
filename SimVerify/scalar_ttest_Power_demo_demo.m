function scalar_ttest_Power_demo_demo
dirname = spm_select(1, 'dir');

filenames = cellstr(spm_select(Inf, 'image'));
mat1 = spm_read_vols(spm_vol(filenames{1}));
Niter = 1000;
Tval = zeros(numel(filenames) - 1, Niter);
for aa = 2:numel(filenames)
    mat2 = spm_read_vols(spm_vol(filenames{aa}));
    for bb = 1:Niter
        Tval(aa - 1, bb) = scalar_ttest_Power(mat1, mat2);
    end
    
end

save(fullfile(dirname, 'Tval.mat'), 'Tval');
