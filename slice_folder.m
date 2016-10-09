for aa = 1:182
    newFolder = ['slice_', num2str(aa)];
    mkdir(newFolder);
    
    files = dir(['*_', num2str(aa), '.mat']);
    for bb = 1:numel(files)
        movefile(files(bb).name, newFolder);
    end
end