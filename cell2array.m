function maT2 = cell2array(aCell, flag)
%used to transform a cell with element as n*m matrix to a high dimension
%matrix.
% Input:
%   flag -  0 for no logm, 1 for logm
%Example:
%aa = {eye(3), zeros(3); ones(3), eye(3)};
%maT = cell2array(aa); %maT is a 2*2*9 matrix.
%
%
warning off
[size_r2, size_c2] = size(aCell);
if flag
    maT_temp2 = cellfun(@(x) reshape(logm(x), 1, 1, 1, []), aCell, 'uniformOutput', false);
else
    maT_temp2 = cellfun(@(x) reshape(x, 1, 1, 1, []), aCell, 'uniformOutput', false);
end
maT2 = reshape(cat(1, maT_temp2{:}), size_r2, size_c2, []);
warning on