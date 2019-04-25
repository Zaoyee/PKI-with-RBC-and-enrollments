function output = DESpermInitial(in)
% THE FIRST STEP PERMUTATION FOR DES 

load IPmatrix.mat IP

if length(in) ~= 64
    error(' Must have 64 bits input')
end

% temp = mod(in, 2);

%  output = reshape(output, [8 8]);

output = zeros(8,8);

for i = 1:64
    [row, col] = find(IP == i);
    output(row, col) = in(i);
end

output = output';
output = output(:)';


