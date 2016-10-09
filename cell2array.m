function maT = cell2array(aCell)
%used to transform a cell with element as n*m matrix to a high dimension
%matrix.
%Example:
%aa = {eye(3), zeros(3); ones(3), eye(3)};
%maT = cell2array(aa); %maT is a 2*2*9 matrix.
%
%
[size_r, size_c] = size(aCell{1});

maT_temp = arrayfun(@(indx) cellfun(@(maTrix) abstractVal(maTrix, indx), aCell), 1:size_r*size_c, ...
    'UniformOutput', false);

maT = cat(3, maT_temp{:});



function elVal = abstractVal(maTrix, indx)

elVal = maTrix(indx);