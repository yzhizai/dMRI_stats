function sample_dwi_reg_

output_dir = spm_select(1, 'dir', 'choose a directory to store the results file');
bvalfile = spm_select(1, 'bval', ...
    'choose the diffusion direction');
bval = load(bvalfile);

bvecfile = spm_select(1, 'bvec', ...
    'choose the diffusion direction');
bvec = load(bvecfile);
if size(bvec, 1) > size(bvec, 2)
    bvec = bvec';
end

number_volume = length(bval);

dir_z = [0, 0, 1]';
d1 = 1.49*10^(-3); % the unit is mm^2*s^-1
d2 = 0.72*10^(-3);
S0 = 300;
sigma = 4;
N = 20;


D0 = (d1 - d2)*(dir_z*dir_z') + d2*eye(3);
S_final_norm = signal_generate(D0, S0, bval, bvec, sigma, N);

step_i = linspace(d2, d1, 10);
for aa = 1:length(step_i)
    D1 = (d1 - step_i(aa))*(dir_z*dir_z') + step_i(aa)*eye(3);
    
    S_final_abnorm = signal_generate(D1, S0, bval, bvec, sigma, N);
    S = cat(1, S_final_norm, S_final_abnorm)';
    subInd = repmat((1:2*N)',1, number_volume)';
    volInd = repmat(1:number_volume, 2*N, 1)';
    group = repmat({'HC', 'PAT'}, numel(S)/2, 1);

    struct_dat = struct('subInd', subInd(:), 'volInd' , volInd(:), ...
        'Val', S(:));
    table_dat = struct2table(struct_dat);
    table_dat.group = group(:);
    filename = fullfile(output_dir, sprintf('sim_dataset_expand_%02d.csv', aa));
    writetable(table_dat, filename);
end



function S_final = signal_generate(D, S0, bval, bvec, sigma, N)
persistent b number_dwi  number_non_dwi
b = max(bval); % the maximum of the bval array is enough for following procedure.
number_dwi = sum(sum(bval > 10));
number_non_dwi = length(bval) - number_dwi;

S_single = S0*cellfun(@(x) exp(-b*x'*D*x), num2cell(bvec, 1));
S_initial = repmat(S_single, N, 1);
rician_noise = ricianrnd(0, sigma, [N, number_dwi]);
rician_noise_all = cat(2, zeros(N, number_non_dwi), rician_noise);

S_final = S_initial + rician_noise_all;

