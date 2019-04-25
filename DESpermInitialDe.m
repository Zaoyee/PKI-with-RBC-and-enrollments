function output = DESpermInitialDe(in)
% THE FIRST STEP PERMUTATION FOR DES 

load IPmatrix.mat IP

if length(in) ~= 64
    error(' Must have 64 bits input')
end

% temp = mod(in, 2);

%  output = reshape(output, [8 8]);

output = zeros(1,64);

for i = 1:64
    realIndex = IP(i);
    output(realIndex) = in(i);
end

