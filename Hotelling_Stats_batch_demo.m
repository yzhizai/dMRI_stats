function Hotelling_Stats_batch_demo

foldernames = cellstr(spm_select(Inf, 'dir'));

filename2 = spm_select(1, 'image');
V = spm_vol(filename2);
for aa = 1:numel(foldernames)
    cd(foldernames{aa});
    
    Dat = load('sliceData.mat');

    T2 = Hotelling_Stats(Dat.sliceData, 10, 10);


    fname2 = 'T2.nii';

    V2 = V;

    V2.fname = fname2;
    V2.dim = [V.dim(1:2), 1];

    V2 = spm_create_vol(V2);

    spm_write_plane(V2, T2, 1);
end

