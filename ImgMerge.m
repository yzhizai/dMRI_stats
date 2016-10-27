function ImgMerge
foldername = cellstr(spm_select(Inf, 'dir'));
N_folder = numel(foldername);

filename = fullfile(foldername{1}, 'T2.nii');
V = spm_vol(filename);

T2 = zeros([V.dim(1:2), N_folder]);
for aa = 1:N_folder
    [pat, tit] = fileparts(foldername{aa});
    s = textscan(tit, '%s', 'delimiter', '_');
    nslice = str2double(s{1}{2});
    
    Y1 = spm_read_vols(spm_vol(fullfile(foldername{aa}, 'T2.nii')));
    T2(:, :, nslice) = Y1; 
end

datMat = {T2};

dirname = pat;
fname = {'T2_3d.nii'};

cellfun(@(x, y) write2store(dirname, V, N_folder, x, y), fname, datMat);

function write2store(dirname, V, N_folder, fname, Y)

V.fname = fullfile(dirname, fname);
V.dim = [V.dim(1:2), N_folder];

V = spm_create_vol(V);
spm_write_vol(V, Y);


