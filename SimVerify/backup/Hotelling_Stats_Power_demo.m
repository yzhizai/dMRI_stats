function T2 = Hotelling_Stats_Power_demo
filename1 = spm_select(1, 'mat');
filename2 = spm_select(1, 'mat');

siT1 = load(filename1);
siT2 = load(filename2);

Niter = 1000;
T2 = ones(Niter, 1);
for aa = 1:1000
    T2(aa) = Hotelling_Stats_Power(siT1, siT2);
end
