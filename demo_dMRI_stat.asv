function demo_dMRI_stat

for bb = 1:10000
    Y = Y_generate;
    YMat1 = Y(:, :, :, 1);
    YMat2 = Y(:, :, :, 2);
    
    Y1_ = mean(YMat1, 3);
    Y2_ = mean(YMat2, 3);
    
    [V1, ~] = eig(Y1_);
    [V2, ~] = eig(Y2_);
    
    E11 = E_func(1, 1);
    E22 = E_func(2, 2);
    E33 = E_func(3, 3);
    
    J_U1 = [matTvec(V1*E11*V1'), matTvec(V1*E22*V1'), matTvec(V1*E33*V1')];
    J_U2 = [matTvec(V2*E11*V2'), matTvec(V2*E22*V2'), matTvec(V2*E33*V2')];
    
    
    omega = zeros(12, 12);
    for i = 1:3
        for j = 1:3
            Eij = E_func(i, j);
            hij = 1/2*diag(V2'*Eij*V2 + V1'*Eji*V1);
            wij = [matTvec(Eij) - J_U1*hij; -matTvec(Eij) + J_U2*hij];
            omega = omega + wij*wij';         
        end
    end
    Omega = omega*50*50/100; 
    
end

