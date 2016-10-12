function matT4D(foldername)
%merge each subjects' slice data to a 4D matrix, which stored in 
%sliceData.mat file.
%
%Note: better to distinguish the different group.
oldpath = pwd;
cd(foldername);

fList = dir('*mat');
SiT0 = load(fList(1).name);
sliceData = cell2array(SiT0.SiT_slice);

for aa = 2:numel(fList)
    SiT = load(fList(aa).name);
    temp = cell2array(SiT.SiT_slice);
    sliceData = cat(4, sliceData, temp);
end

save('sliceData.mat',  'sliceData');

cd(oldpath);