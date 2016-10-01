function Y = Y_generate
%Usage: Y =  Y_GENERATE;
%
%See also: WISHRND, MVNRND
%
%Institute of High Energy Physics
%Shaofeng Duan
%2016-09-30
Sigma = wishrnd(eye(6), 6);
Mu1 = diag([1, 2, 4]);
Q = Qmat(0.5, [1, 1, 1]/sqrt(3));
Mu2 = Q*Mu1*Q';

YMat1 = zeros(3, 3, 50);
YMat2 = zeros(3, 3, 50);

for aa = 1:50
    Y1 = vecTmat(mvnrnd(matTvec(Mu1), Sigma));
    YMat1(:, :, aa) = Y1;
    Y2 = vecTmat(mvnrnd(matTvec(Mu2), Sigma));
    YMat2(:, :, aa) = Y2;
end

Y = cat(4, YMat1, YMat2);



% convert vector to matrix
function matv = vecTmat(vecv)

Y11 = vecv(1);
Y22 = vecv(2);
Y33 = vecv(3);
Y12 = vecv(4)/sqrt(2);
Y13 = vecv(5)/sqrt(2);
Y23 = vecv(6)/sqrt(2);

matv = [Y11, Y12, Y13; ...
        Y12, Y22, Y23; ...
        Y13, Y23, Y33];
    
     
% get the Rodrigures's rotation matrix        
function Q = Qmat(theta, orie)

a1 = orie(1);
a2 = orie(2);
a3 = orie(3);

matV = [0, -a3, a2; a3, 0, -a1; -a2, a1, 0];

Q = expm(0.5*matV);



