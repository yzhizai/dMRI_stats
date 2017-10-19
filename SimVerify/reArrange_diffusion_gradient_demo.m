bvec_file = spm_select(1, 'bvec');

bvec = load(bvec_file);

[dim_1, dim_2] = size(bvec);

if dim_2 < dim_1
    bvec = bvec';
end

new_order = reArrange_diffusion_gradient(bvec);