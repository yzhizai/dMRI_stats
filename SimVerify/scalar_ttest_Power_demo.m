function Tval = scalar_ttest_Power_demo

filename1 = spm_select(1, 'image');
filename2 = spm_select(1, 'image');

mat1 = spm_read_vols(spm_vol(filename1));
mat2 = spm_read_vols(spm_vol(filename2));

Niter = 1000;

Tval = zeros(Niter, 1);
for aa = 1:Niter
    Tval(aa) = scalar_ttest_Power(mat1, mat2);
end