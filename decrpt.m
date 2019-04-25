function [Lnext, Rnext] = decrpt(L, R, n, rawKey)
% RECURION FOR DECRPTION PROGRESS


% Get the next L and R
Rnext = L;
Lnext = xor(fFunction(L, n, rawKey), R);

if n > 1
    [Lnext, Rnext] = decrpt(Lnext, Rnext, n-1, rawKey);
end
