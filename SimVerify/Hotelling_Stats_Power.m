function T2 = Hotelling_Stats_Power(siT1, siT2)
%after dataConvert, to do test with this function

siT_nine1 = cellfun(@(x) reshape(x(:), 1, 1, 1, []), siT1.SimTensor, 'UniformOutput', false);
siT_mat1_temp = cat(1, siT_nine1{:});
siT_mat1 = reshape(siT_mat1_temp, 10, 10, 10, []);

siT_nine2 = cellfun(@(x) reshape(x(:), 1, 1, 1, []), siT2.SimTensor, 'UniformOutput', false);
siT_mat2_temp = cat(1, siT_nine2{:});
siT_mat2 = reshape(siT_mat2_temp, 10, 10, 10, []);

rndIdx = unidrnd(1000, 10, 1);
[subx, suby, subz] = ind2sub([10, 10, 10], rndIdx);

sliceData = [];
for aa = 1:numel(rndIdx)
    temp = reshape(siT_mat1(subx(aa), suby(aa), subz(aa), :), 1, 1, []);
    sliceData = cat(4, sliceData, temp);
end
for bb = 1:numel(rndIdx)
    temp = reshape(siT_mat2(subx(bb), suby(bb), subz(bb), :), 1, 1, []);
    sliceData = cat(4, sliceData, temp);
end

T2 = Hotelling_Stats(sliceData, 10, 10);






