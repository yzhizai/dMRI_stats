function [T2, f] = Hotelling_Stats(sliceData, n1, n2)
%Input:
%  
warning off
grp1 = sliceData(:, :, :, 1:n1);
grp2 = sliceData(:, :, :, n1 + 1:end);

d = Nine2Six(mean(grp1, 4) - mean(grp2, 4));
S1_temp = [];
for aa = 1:size(grp1, 4)
    subgrp = grp1(:, :, :, aa);
    subgrp = Nine2Six(subgrp);
    subgrpC = num2cell(subgrp, 3);
    temp = cell2array(cellfun(@(x, y) x(:)*y(:)', subgrpC, subgrpC, 'UniformOutput', false)); 
    S1_temp = cat(4, S1_temp, temp);
end

S1 = sum(S1_temp, 4)/(size(S1_temp, 4) - 1);

S2_temp = [];
for aa = 1:size(grp2, 4)
    subgrp = grp2(:, :, :, aa);
    subgrp = Nine2Six(subgrp);
    subgrpC = num2cell(subgrp, 3);
    temp = cell2array(cellfun(@(x, y) x(:)*y(:)', subgrpC, subgrpC, 'UniformOutput', false)); 
    S2_temp = cat(4, S2_temp, temp);
end
S2 = sum(S2_temp, 4)/(size(S2_temp, 4) - 1);

S = S1/n1 + S2/n2;

T2 = cellfun(@hotelling_t2, num2cell(d, 3), num2cell(S, 3));
f = cellfun(@(dmat, Smat, S1mat, S2mat) hotelling_dof(dmat, Smat, S1mat, S2mat, n1, n2), num2cell(d, 3), ...
    num2cell(S, 3), num2cell(S1, 3), num2cell(S2, 3));
warning on
% transfer A(:) to vecd(reshape(A, 3, 3)) type.
function mat6 = Nine2Six(mat9)

mat6 = mat9(:, :, [1, 5, 9, 4, 7, 8]);
mat6(:, :, 4:6) = sqrt(2)*mat6(:, :, 4:6);

function t2 = hotelling_t2(dmat, Smat)

t2 = dmat(:)'/reshape(Smat, 6, 6)*dmat(:);

function dof = hotelling_dof(dmat, Smat, S1mat, S2mat, n1, n2)
d = dmat(:);
S = reshape(Smat, 6, 6);
S1 = reshape(S1mat, 6, 6);
S2 = reshape(S2mat, 6, 6);

temp = ((d'/S*S1/S*d)/(n1*d'/S*d))^2/(n1 -1) + ((d'/S*S2/S*d)/(n2*d'/S*d))^2/(n2 -1);
dof = 1/temp;
