function dataConvert_demo

foldername = spm_select(Inf, 'dir');
foldername = cellstr(foldername);
h = waitbar(0, 'waiting...');
for aa = 1:numel(foldername)
    dataConvert(foldername{aa});
    waitbar(aa/numel(foldername));
end
close(h);
