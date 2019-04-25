function [Lnext, Rnext] = encrpt(L, R, n, rawKey)
% RECURION FOR ENCRPTION PROGRESS


% Get the next L and R
Lnext = R;
Rnext = xor(fFunction(R, n, rawKey), L);

if n < 16
    [Lnext, Rnext] = encrpt(Lnext, Rnext, n+1, rawKey);
end
    


