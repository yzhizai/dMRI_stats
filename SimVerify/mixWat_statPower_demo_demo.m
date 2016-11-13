function mixWat_statPower_demo_demo

dirname = spm_select(1, 'dir');

filenames1 = cellstr(spm_select(Inf,'dyads1.nii', 'choose the first direction file'));
filenames2 = cellstr(spm_select(Inf,'dyads2.nii', 'choose the second direction file'));

IterN = 1000;
Fval = zeros(numel(filenames1) - 1, IterN);
for aa = 2:numel(filenames1)
    
    filename1 = filenames1([1, aa]);
    filename2 = filenames2([1, aa]);

    for bb = 1:IterN
        Fval(aa - 1, bb) = mixWat_statPower(filename1, filename2);
    end
end

save(fullfile(dirname, 'fval.mat'), 'Fval');
