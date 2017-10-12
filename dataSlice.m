function dataSlice
% For the data was big, load data become a RAM-cosumed procedure. So we
% devide each mat file in slices.
filenames = spm_select(Inf, 'mat');
filenames = cellstr(filenames);

for aa = 1:numel(filenames)
    [pat, tit, ext] = fileparts(filenames{aa});
    SiT = load(filenames{aa});
    for bb = 1:size(SiT.SimTensor, 3)
%     for bb = 88
        SiT_slice = SiT.SimTensor(:, :, bb);
        save(fullfile(pat, [tit, '_', num2str(bb), ext]), 'SiT_slice');
    end
    clear SiT;
end
