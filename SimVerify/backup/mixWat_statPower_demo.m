function Fval = mixWat_statPower_demo

filenames1 = cellstr(spm_select(Inf,'dyads1.nii', 'choose the first direction file'));
filenames2 = cellstr(spm_select(Inf,'dyads2.nii', 'choose the second direction file'));

IterN = 1000;
Fval = zeros(IterN, 1);

for aa = 1:IterN
    Fval(aa) = mixWat_statPower(filenames1, filenames2);
end