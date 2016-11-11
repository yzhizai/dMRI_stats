function decayS_ag_demo(lambda)

outputDir = spm_select(1, 'dir');
rng('default')
tensorDir1 = orth(rand(3));% generate 3 direction.

bvalfile = spm_select(1, 'bval', ...
    'choose the diffusion direction');
bval = load(bvalfile);
bvecfile = spm_select(1, 'bvec', ...
    'choose the diffusion direction');
bvec = load(bvecfile);

S1 = decayS(tensorDir1, bval, bvec);
S0 = 300;


for aa = pi/12:pi/12:pi/2
    
    fatherfolder = fullfile(outputDir, sprintf('theta_%02d', round(aa*180/pi)));
    mkdir(fatherfolder);
    copyfile(bvecfile, fullfile(fatherfolder, 'bvecs'));
    copyfile(bvalfile, fullfile(fatherfolder, 'bvals'));
     
    theta = normrnd(aa, pi/180, 10, 10, 10);
    decF = arrayfun(@(x) decF_angle(x, tensorDir1, bval, bvec, lambda, S1, S0), ...
        theta, 'UniformOutput', false);
  
    %reformat the 3D cell to 4D array, first 3 dimensions was equalvalent, the 4 dimension was the cell{xx}(:)  
    temp = cellfun(@(x) reshape(x, 1, 1, 1, []), decF, 'UniformOutput', false);
    S_temp = cat(1, temp{:});
    S = reshape(S_temp, 10, 10, 10, []);
    outputFiles(fatherfolder, S);   
end

function S = decF_angle(x, tensorDir1, bval, bvec, lambda, S1, S0)
Rvec = normrnd(x, pi/180)*tensorDir1(:, 3)';
Rmat = rotationVectorToMatrix(Rvec); %make the tensorDir rotate with z-axis with 90 to
%produce tensorDir2;
tensorDir2 = Rmat*tensorDir1;
S2 = decayS(tensorDir2, bval, bvec);
S = S0*(lambda*S1 + (1 - lambda)*S2);

%output simulated data.
function outputFiles(dirname, S)
[xx, yy, zz, ww] = size(S);
fname = fullfile(dirname, 'data.nii');
ni = nifti;
ni.dat = file_array(fname, [xx, yy, zz, ww], [16, spm_platform('bigend')],...
    0, 1, 0);
ni.mat = eye(4);
ni.mat0 = eye(4);
ni.descrip = 'simulated data';

create(ni);
for i=1:size(ni.dat,4)
    ni.dat(:,:,:,i) = S(:, :, :, i);
end



fname = fullfile(dirname, 'nodif_brain_mask.nii');
ni_mask = nifti;
ni_mask.dat = file_array(fname, [xx, yy, zz], [16, spm_platform('bigend')],...
    0, 1, 0);
ni_mask.mat = eye(4);
ni_mask.mat0 = eye(4);
ni_mask.descrip = 'mask data';
create(ni_mask);    
ni_mask.dat(:, :, :) = ones(xx, yy, zz);



