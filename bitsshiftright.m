function vector = bitsshiftright(in, n)
% shift bits to the right, n is number of shifting bits

le = length(in);

vector = zeros(1,le);

for i = le:-1:1+n
    vector(i) = in(i-n);
end
    