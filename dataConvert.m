function dataConvert(foldername)

oldpath = pwd();
cd(foldername);

dyads1_array = spm_read_vols(spm_vol('dyads1.nii'));
dyads2_array = spm_read_vols(spm_vol('dyads2.nii'));

f1 = spm_read_vols(spm_vol('mean_f1samples.nii'));
f2 = spm_read_vols(spm_vol('mean_f2samples.nii'));

dyads1 = arrayfun(@scalar2vector, dyads1_array(:, :, :, 1), dyads1_array(:, :, :, 2), ...
    dyads1_array(:, :, :, 3), 'UniformOutput', false);
dyads2 = arrayfun(@scalar2vector, dyads2_array(:, :, :, 1), dyads2_array(:, :, :, 2), ...
    dyads2_array(:, :, :, 3), 'UniformOutput', false);


SimTensor = cellfun(@tensorMerge, num2cell(f1), num2cell(f2), dyads1, dyads2, ...
    'UniformOutput', false);

save([foldername, '.mat'], 'dyads1', 'dyads2', 'f1', 'f2', 'SimTensor');

cd(oldpath)


function vect = scalar2vector(sca1, sca2, sca3)

vect = [sca1, sca2, sca3]';

function siT = tensorMerge(f1, f2, vec1, vec2)

if f1 < 0.1
    siT = zeros(numel(vec1));
    return
end
vec3 = cross(vec1, vec2);
vec3 = vec3/norm(vec3);

V = [vec1, vec3];
D = diag(f1, f2);

siT = V*D/V;


