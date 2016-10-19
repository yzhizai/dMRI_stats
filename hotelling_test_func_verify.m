% function hotelling_test_func_verify
clear all
close all
n1 = 10;
n2 = 8;
indx = 67;
indy = 109;

dat = load('sliceData.mat');

fieldnameCell = fieldnames(dat);
fieldname = fieldnameCell{1};
S = substruct('.', fieldname);

slicedata = subsref(dat, S);

valmatOri = slicedata(indx, indy, :, :);
valmat = reshape(valmatOri, 9, 18)';
valmat2R = valmat(:, [1, 5, 9, 4, 7, 8]);
valmat2R(:, 4:6) = sqrt(2)*valmat2R(:, 4:6);

x_ = mean(valmat2R(1:n1, :))';
y_ = mean(valmat2R(n1+1:end, :))';

meanMat = [repmat(x_', n1, 1); repmat(y_', n2, 1)];

valmatMean = valmat2R - meanMat;

W = zeros(size(valmat2R, 2));
for aa = 1:size(valmatMean, 1)
    xy = valmatMean(aa, :)';
    varaxy = xy*xy';
    W = W + varaxy;
end
W = W/(n1 + n2 - 2);

T2 = n1*n2/(n1 + n2)*(x_ - y_)'/W*(x_ - y_);
Fval = (n1 + n2 - 6 - 1)/((n1 + n2 -2)*6)*T2;



% valtable = array2table(valmat2R);
% valtable.Properties.VariableNames  = {'xx', 'yy', 'zz', 'xy', 'xz', 'yz'};
% 
% grpf = table([repmat('con', 10, 1); repmat('pat', 8, 1)], ...
%     'VariableNames', {'group'});
% dataAna = [valtable, grpf];
% 
% rm = fitrm(dataAna, 'xx-yz~group');
% manova(rm)



% function mat6 = Nine2Six(mat9)
% 
% mat6 = mat9(:, :, [1, 5, 9, 4, 7, 8]);
% mat6(:, :, 4:6) = sqrt(2)*mat6(:, :, 4:6);
