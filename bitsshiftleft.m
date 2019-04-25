function vector = bitsshiftleft(in, n)
% shift bits to the left, n is number of shifting bits

le = length(in);

vector = zeros(1,le);

vector(1:le-n) = in(n+1:le);