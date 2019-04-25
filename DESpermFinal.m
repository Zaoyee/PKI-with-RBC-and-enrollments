function result = DESpermFinal(in)
% THE FINAL STEP PERMUTATION FOR DES
%   Tips: The input must be a vector.

load FPmatrix.mat FP


output = zeros(8,8);

for i = 1:64
    [row, col] = find(FP == i);
    output(row, col) = in(i);
end

output = output';
result = output(:)';

% Make the output as string as remove the SPACE
% result = num2str(result);
% result = strrep(result, ' ', '');