function dataConvert(foldername)
%Usage: DATACONVERT(foldername)
%
%This function is used to convert the bedpostX files to mat type and to 
%generate a tensor-like matrix.
%Input:
%  foldername -  a folder contains 4 files
% 
%Institute of High Energy Physics
%Shaofeng Duan
%2016-10-8


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

save([foldername, '.mat'], 'SimTensor');

cd(oldpath)


function vect = scalar2vector(sca1, sca2, sca3)

vect = [sca1, sca2, sca3]';

function siT = tensorMerge(f1, f2, vec1, vec2)

if f1 < 0.1 || isequal(zeros(3, 1), vec1) || isequal(zeros(3, 1), vec2) %promise the analysis be in the brain tissue.
    siT = zeros(numel(vec1));
    return
end
vec1 = sign(vec1(3))*vec1;    %modify the vector to align with the z-axis.
vec2 = sign(vec1'*vec2)*vec2; %promise the angle between two vector less than 90.

vec3 = cross(vec1, vec2);
vec3 = vec3/norm(vec3);

vec4 = cross(vec1, vec3);
vec4 = vec4/norm(vec4);

% CosTheta = vec1'*vec2
CosTheta = vec1'*vec2*(f2/f1 + f2); %add a weight to reduce the random effects.

V = [vec1, vec3, vec4];
D = diag([f1, f2, CosTheta]);

siT = V*D/V;


