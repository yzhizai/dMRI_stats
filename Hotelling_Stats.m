function T2 = Hotelling_Stats(sliceData, n1, n2)
%Input:
%  sliceData - 
warning off
% grp1 = sliceData(:, :, :, 1:n1);
% grp2 = sliceData(:, :, :, n1 + 1:end);
% 
% x_ = mean(grp1, 4);
% y_ = mean(grp2, 4);
% 
% meanMat = cat(4, repmat(x_, 1, 1, 1, n1), repmat(y_, 1, 1, 1, n2));
% 
% sliceDataMean = sliceData - meanMat;
% 
% d = Nine2Six(x_ - y_);

% S_temp = [];
% for aa = 1:(n1+n2)
%     subgrp = sliceDataMean(:, :, :, aa);
%     subgrp = Nine2Six(subgrp);
%     subgrpC = num2cell(subgrp, 3);
%     temp = cell2array(cellfun(@(x, y) x(:)*y(:)', subgrpC, subgrpC, 'UniformOutput', false), 0); 
%     S_temp = cat(4, S_temp, temp);
% end
% 
% S = sum(S_temp, 4);

sliceData_cell = num2cell(sliceData, [3, 4]);
[dim_1, dim_2] = size(sliceData_cell);
T2 = zeros(dim_1, dim_2);
for bb = 1:dim_2
    for aa = 1:dim_1
        T2(aa, bb) = hotelling_t2(sliceData_cell{aa, bb}, n1, n2);
    end
end

warning on

function T2 = hotelling_t2(samples, n1, n2)

dat_mat = reshape(samples, 9, n1 + n2)';
dat_mat = dat_mat(:, [1, 5, 9, 4, 7, 8]);
dat_mat(:, 4:6) = dat_mat(:, 4:6)*sqrt(2);
x_part = dat_mat(1:n1, :);
y_part = dat_mat(n1+1:end, :);

x_part_mean = mean(x_part, 1);
y_part_mean = mean(y_part, 1);

x_part_centered = x_part - repmat(x_part_mean, n1, 1);
y_part_centered = y_part - repmat(y_part_mean, n2, 1);

x_part_cov = x_part_centered'*x_part_centered;
y_part_cov = y_part_centered'*y_part_centered;

total_cov = (x_part_cov + y_part_cov)/(n1 + n2 - 2);
t_square = (n1*n2/(n1 + n2))*(x_part_mean - y_part_mean)/total_cov*(x_part_mean - y_part_mean)';
T2 = (n1 + n2 - 7)/(n1 + n2 - 2)/6*t_square;
% transfer A(:) to vecd(reshape(A, 3, 3)) type.
% function mat6 = Nine2Six(mat9)
% 
% mat6 = mat9(:, :, [1, 5, 9, 4, 7, 8]);
% mat6(:, :, 4:6, :) = sqrt(2)*mat6(:, :, 4:6);

% function T2 = hotelling_t2(dmat, Smat, n1, n2)
% 
% warning off
% x_y = dmat(:);
% W = reshape(Smat, 6, 6)/(n1 + n2 -2);
% 
% t2 = n1*n2/(n1 + n2)*x_y'/W*x_y;
% 
% T2 = (n1 + n2 -6 -1)/((n1 + n2 - 2)*6)*t2;
% warning on


