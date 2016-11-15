function decayS_demo

outputDir = spm_select(1, 'dir');
% rng('default')
tensorDir1 = eye(3); % generate 3 direction.

bvalfile = spm_select(1, 'bval', ...
    'choose the diffusion direction');
bval = load(bvalfile);
bvecfile = spm_select(1, 'bvec', ...
    'choose the diffusion direction');
bvec = load(bvecfile);

Rvec = pi/2*tensorDir1(:, 3)';
Rmat = rotationVectorToMatrix(Rvec); %make the tensorDir rotate with z-axis with 90 to
%produce tensorDir2;

tensorDir2 = Rmat*tensorDir1;

S1 = decayS(tensorDir1, bval, bvec);
S2 = decayS(tensorDir2, bval, bvec);

S0 = 300;

S = S0*(0.7*S1 + 0.3*S2);

outputFiles(outputDir, S);


%output simulated data.
function outputFiles(dirname, S)
fname = fullfile(dirname, 'data.nii');
ni = nifti;
ni.dat = file_array(fname, [2, 2, 2, numel(S)], [16, spm_platform('bigend')],...
    0, 1, 0);
ni.mat = eye(4);
ni.mat0 = eye(4);
ni.descrip = 'simulated data';

create(ni);
for i=1:size(ni.dat,4)
    ni.dat(:,:,:,i) = repmat(S(i), 2, 2, 2);
end



fname = fullfile(dirname, 'nodif_brain_mask.nii');
ni_mask = nifti;
ni_mask.dat = file_array(fname, [2, 2, 2], [16, spm_platform('bigend')],...
    0, 1, 0);
ni_mask.mat = eye(4);
ni_mask.mat0 = eye(4);
ni_mask.descrip = 'mask data';

create(ni_mask);    
ni_mask.dat(:, :, :) = ones(2, 2, 2);




