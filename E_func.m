function Eij = E_func(i, j)

ei = zeros(3, 1);
ej = zeros(3, 1);

ei(i) = 1; 
ej(j) = 1;

Eij = (ei*ej' + ej*ei')/2;
