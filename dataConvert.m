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

dyads1_array = spm_read_vols(spm_vol('dyads1_warp.nii'));
dyads2_array = spm_read_vols(spm_vol('dyads2_warp.nii'));

f1 = spm_read_vols(spm_vol('mean_f1samples_warp.nii'));
f2 = spm_read_vols(spm_vol('mean_f2samples_warp.nii'));

[dim_x, dim_y, dim_z] = size(f1);
% dyads1 = arrayfun(@scalar2vector, dyads1_array(:, :, :, 1), dyads1_array(:, :, :, 2), ...
%     dyads1_array(:, :, :, 3), 'UniformOutput', false);
% dyads2 = arrayfun(@scalar2vector, dyads2_array(:, :, :, 1), dyads2_array(:, :, :, 2), ...
%     dyads2_array(:, :, :, 3), 'UniformOutput', false);
dyads1 = num2cell(dyads1_array, 4);
dyads2 = num2cell(dyads2_array, 4);

SimTensor = cell(dim_x, dim_y, dim_z);
for cc = 1:dim_z
    for bb = 1:dim_y
        for aa = 1:dim_x
            SimTensor{aa, bb, cc} = tensorMerge(f1(aa, bb, cc), f2(aa, bb, cc), ...
                dyads1{aa, bb, cc},dyads2{aa, bb, cc});
        end
    end
end
% SimTensor = cellfun(@tensorMerge, num2cell(f1), num2cell(f2), dyads1, dyads2, ...
%     'UniformOutput', false);
save([foldername, '.mat'], 'SimTensor');

cd(oldpath)

% 
% function vect = scalar2vector(sca1, sca2, sca3)
% 
% vect = [sca1, sca2, sca3]';

function siT = tensorMerge(f1, f2, vec1, vec2)

vec1 = vec1(:);
vec2 = vec2(:);

if f1 < 0.1 || isequal(zeros(3, 1), vec1) || isequal(zeros(3, 1), vec2) %promise the analysis be in the brain tissue.
    siT = zeros(numel(vec1));
    return
end
if f2 < 0.15
    siT = (f1 - f2)*(vec1*vec1') + f2*eye(3);
else
    vec1 = sign(vec1(3))*vec1;    %modify the vector to align with the z-axis.
    vec2 = sign(vec1'*vec2)*vec2; %promise the angle between two vector less than 90.
    vec3 = cross(vec1, vec2);
    vec3 = vec3/norm(vec3);
    vec3 = sign(vec3(3))*vec3;
    vec4 = cross(vec1, vec3);
    vec4 = vec4/norm(vec4);
    vec4 = sign(vec4(3))*vec4;
    % CosTheta = vec1'*vec2
    CosTheta = dot(vec1, vec2); %add a weight to reduce the random effects.

    V = [vec1, vec3, vec4];
    D = diag([f1, f2*sqrt(1 - CosTheta^2), f2*CosTheta]);
    siT = V*D/V;
end



