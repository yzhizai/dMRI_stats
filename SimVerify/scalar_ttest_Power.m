function Tval = scalar_ttest_Power(mat1, mat2)
%Input:
%  mat1 & mat2 - the scalar image matrix, such as FA, MD..
rndIdx = unidrnd(1000, 10, 1);
[subx, suby, subz] = ind2sub([10, 10, 10], rndIdx);

dat2test = [];
for aa = 1:numel(rndIdx)
    temp = mat1(subx(aa), suby(aa), subz(aa));
    dat2test = [dat2test, temp];
end
for bb = 1:numel(rndIdx)
    temp = mat2(subx(aa), suby(aa), subz(aa));
    dat2test = [dat2test, temp];
end

[~, ~, ~, stats] = ttest2(dat2test(1:10), dat2test(11:end));

Tval = stats.tstat;


