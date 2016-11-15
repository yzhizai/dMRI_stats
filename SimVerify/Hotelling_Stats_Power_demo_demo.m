function Hotelling_Stats_Power_demo_demo
dirname = spm_select(1, 'dir');

filenames = cellstr(spm_select(Inf, 'mat'));
siT1 = load(filenames{1});

Niter = 1000;
T2 = zeros(numel(filenames) - 1, Niter);
for aa = 2:numel(filenames)
    siT2 = load(filenames{aa});   
    for bb = 1:Niter
        T2(aa - 1,bb) = Hotelling_Stats_Power(siT1, siT2);
    end
end

save(fullfile(dirname, 'T2.mat'), 'T2');
