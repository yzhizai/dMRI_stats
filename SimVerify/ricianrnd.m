function r = ricianrnd(mu, sigma, varargin)
% This function is used to generate the sample following racian distribution.
sizeOut = varargin{:};
ele_x = normrnd(mu, sigma, sizeOut);
ele_y = normrnd(mu, sigma, sizeOut);

r = sqrt(ele_x.^2 + ele_y.^2);

sign_mat = rand(sizeOut);
sign_mat(sign_mat > 0.5) = 1;
sign_mat(sign_mat < 0.5) = -1;

r = r.*sign_mat;



