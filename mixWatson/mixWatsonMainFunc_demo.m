function mixWatsonMainFunc_demo

filenames1 = cellstr(spm_select(Inf, '.*dyads1.nii', 'choose dyads1 files'));
filenames2 = cellstr(spm_select(Inf, '.*dyads2.nii', 'choose dyads2 files'));

Fval = mixWatsonMainFunc(filenames1, filenames2, 10, 10);

filename = spm_select(1, 'image', 'choose a reference file');
outputdir = spm_select(1, 'dir', 'choose a output dir');

V = spm_vol(filename);
V.fname = fullfile(outputdir, 'mixWatson_F.nii');
V = spm_create_vol(V);
spm_write_vol(V, Fval);

