function Hotelling_Stats_demo

filename = spm_select(1, 'mat');

Dat = load(filename);

[T2, dof] = Hotelling_Stats(Dat.sliceData, 9, 9);

filename2 = spm_select(1, 'image');

V = spm_vol(filename2);

fname1 = 'dof.nii';
fname2 = 'T2.nii';

V1 = V;
V2 = V;

V1.fname = fname1;
V2.fname = fname2;
V1.dim = [V.dim(1:2), 1];
V2.dim = [V.dim(1:2), 1];

V1 = spm_create_vol(V1);
V2 = spm_create_vol(V2);

spm_write_plane(V2, T2, 1);
spm_write_plane(V1, dof,1);