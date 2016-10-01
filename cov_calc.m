function S = cov_calc(YMat)
% used to calculate the group sample covariance.
ldim = numel(size(YMat)); %choose the last dim.
n = size(YMat, ldim);
Y_ = mean(YMat, ldim);

YMat_center = YMat - repmat(Y_, [ones(1, ldim -1), n]);

S = zeros(6);

for aa = 1:n
    S = matTvec(YMat_center(:, :, aa)) * matTvec(YMat_center(:, :, aa))' + S;
end

