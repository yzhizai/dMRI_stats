function slice_folder(varargin)
sliceN = 8;
if nargin > 0
    sliceN = varargin{1};
end
for aa = 1:sliceN
    newFolder = ['slice_', num2str(aa)];
    mkdir(newFolder);
    
    files = dir(['*_', num2str(aa), '.mat']);
    for bb = 1:numel(files)
        movefile(files(bb).name, newFolder);
    end
end