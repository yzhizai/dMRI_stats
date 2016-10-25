function decayS_demo
rng('default')
tensorDir1 = rand(3);
tensorDir1 = orth(tensorDir1); % generate 3 direction.

bval = load(spm_select(1, 'bval', ...
    'choose the diffusion direction'));
bvec = load(spm_select(1, 'bvec', ...
    'choose the diffusion direction'));

Rvec = pi/2*[0, 0, 1];
Rmat = rotationVectorToMatrix(Rvec); %make the tensorDir rotate with z-axis with 90 to
%produce tensorDir2;

tensorDir2 = Rmat*tensorDir1*Rmat';

S1 = decayS(tensorDir1, bval, bvec);
S2 = decayS(tensorDir2, bval, bvec);

decF = 0.5*S1 + 0.5*S2;
S0 = 300;
S = S0*decF;

fname = 'data.nii';
ni = nifti;
ni.dat = file_array(fname, [16, 16, 8, numel(S)], [16, spm_platform('bigend')],...
    0, 1, 0);
ni.mat = eye(4);
ni.mat0 = eye(4);
ni.descrip = 'simulated data';

create(ni);
for i=1:size(ni.dat,4)
    ni.dat(:,:,:,i) = padarray(repmat(S(i), 8, 8, 4), [4, 4, 2]);
end

fname = 'nodif_brain_mask.nii';
ni_mask = nifti;
ni_mask.dat = file_array(fname, [16, 16, 8], [16, spm_platform('bigend')],...
    0, 1, 0);
ni_mask.mat = eye(4);
ni_mask.mat0 = eye(4);
ni_mask.descrip = 'mask data';

create(ni_mask);    
ni_mask.dat(:, :, :) = padarray(ones(8, 8, 4), [4, 4, 2]);




