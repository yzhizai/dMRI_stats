function matT4D_demo

foldernames = cellstr(spm_select(Inf, 'dir'));

for aa = 1:numel(foldernames)
    matT4D(foldernames{aa});
end