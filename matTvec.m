function vecv = matTvec(matv)
% convert matrix to vector

Y11 = matv(1, 1);
Y22 = matv(2, 2);
Y33 = matv(3, 3);
Y12 = matv(1, 2);
Y13 = matv(1, 3);
Y23 = matv(2 ,3);

vecv = [Y11, Y22, Y33, sqrt(2)*Y12, sqrt(2)*Y13, sqrt(2)*Y23]';