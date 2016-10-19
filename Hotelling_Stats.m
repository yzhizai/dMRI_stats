function T2 = Hotelling_Stats(sliceData, n1, n2)
%Input:
%  
warning off
grp1 = sliceData(:, :, :, 1:n1);
grp2 = sliceData(:, :, :, n1 + 1:end);

x_ = mean(grp1, 4);
y_ = mean(grp2, 4);

meanMat = cat(4, repmat(x_, 1, 1, 1, n1), repmat(y_, 1, 1, 1, n2));

sliceDataMean = sliceData - meanMat;

d = Nine2Six(x_ - y_);

S_temp = [];
for aa = 1:(n1+n2)
    subgrp = sliceDataMean(:, :, :, aa);
    subgrp = Nine2Six(subgrp);
    subgrpC = num2cell(subgrp, 3);
    temp = cell2array(cellfun(@(x, y) x(:)*y(:)', subgrpC, subgrpC, 'UniformOutput', false)); 
    S_temp = cat(4, S_temp, temp);
end

S = sum(S_temp, 4);


T2 = cellfun(@(dmat, Smat) hotelling_t2(dmat, Smat, n1, n2), num2cell(d, 3), num2cell(S, 3));

warning on

% transfer A(:) to vecd(reshape(A, 3, 3)) type.
function mat6 = Nine2Six(mat9)

mat6 = mat9(:, :, [1, 5, 9, 4, 7, 8]);
mat6(:, :, 4:6) = sqrt(2)*mat6(:, :, 4:6);

function T2 = hotelling_t2(dmat, Smat, n1, n2)

x_y = dmat(:);
W = reshape(Smat, 6, 6)/(n1 + n2 -2);

t2 = n1*n2/(n1 + n2)*x_y'/W*x_y;

T2 = (n1 + n2 -6 -1)/((n1 + n2 - 2)*6)*t2;


