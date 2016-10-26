function decayS_demo

outputDir = spm_select(1, 'dir');
rng('default')
tensorDir1 = rand(3);
tensorDir1 = orth(tensorDir1); % generate 3 direction.

bvalfile = spm_select(1, 'bval', ...
    'choose the diffusion direction');
bval = load(bvalfile);
bvecfile = spm_select(1, 'bvec', ...
    'choose the diffusion direction');
bvec = load(bvecfile);

Rvec = pi/2*tensorDir1(:, 3)';
Rmat = rotationVectorToMatrix(Rvec); %make the tensorDir rotate with z-axis with 90 to
%produce tensorDir2;

tensorDir2 = Rmat*tensorDir1*Rmat';

S1 = decayS(tensorDir1, bval, bvec);
S2 = decayS(tensorDir2, bval, bvec);

S0 = 300;

for aa = 0.1:0.1:0.9
    fatherfolder = fullfile(outputDir, sprintf('lamba_%02d', aa*100));
    mkdir(fatherfolder);
    lambda = normrnd(aa, 0.01, 10, 1);
    decF = arrayfun(@(x) x*S1 + (1 - x)*S2, lambda, 'UniformOutput', false);
    for bb = 1:numel(decF)
        sonfolder = fullfile(fatherfolder, sprintf('sub_%03d', bb));
        mkdir(sonfolder);
        copyfile(bvecfile, fullfile(sonfolder, 'bvecs'));
        copyfile(bvalfile, fullfile(sonfolder, 'bvals'));
        S = S0*decF{bb};
        outputFiles(sonfolder, S);
    end      
end

outputFiles('.', S);


%output simulated data.
function outputFiles(dirname, S)
fname = fullfile(dirname, 'data.nii');
ni = nifti;
ni.dat = file_array(fname, [16, 16, 8, numel(S)], [16, spm_platform('bigend')],...
    0, 1, 0);
ni.mat = eye(4);
ni.mat0 = eye(4);
ni.descrip = 'simulated data';

create(ni);
for i=1:size(ni.dat,4)
    ni.dat(:,:,:,i) = padarray(repmat(S(i), 2, 2, 2), [7, 7, 3]);
end



fname = fullfile(dirname, 'nodif_brain_mask.nii');
ni_mask = nifti;
ni_mask.dat = file_array(fname, [16, 16, 8], [16, spm_platform('bigend')],...
    0, 1, 0);
ni_mask.mat = eye(4);
ni_mask.mat0 = eye(4);
ni_mask.descrip = 'mask data';

create(ni_mask);    
ni_mask.dat(:, :, :) = padarray(ones(2, 2, 2), [7, 7, 3]);




