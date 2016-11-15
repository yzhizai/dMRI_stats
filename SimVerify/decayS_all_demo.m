function decayS_all_demo

outputDir = spm_select(1, 'dir');
bvalfile = spm_select(1, 'bval', ...
    'choose the diffusion direction');
bval = load(bvalfile);
bvecfile = spm_select(1, 'bvec', ...
    'choose the diffusion direction');
bvec = load(bvecfile);
%% change angle
for aa = 0.5:0.1:0.9
    decayS_ag_demo(aa, outputDir, bvalfile, bvecfile, bval, bvec);
end
%% change partial volume
for bb = pi/12:pi/12:pi/2
    decayS_pv_demo(bb, outputDir, bvalfile, bvecfile, bval, bvec);
end
%% change total angle
decayS_rot_demo(pi/2, 0.7, outputDir, bvalfile, bvecfile, bval, bvec);