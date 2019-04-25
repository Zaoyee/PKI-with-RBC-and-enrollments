function result = DESpermFinalDe(in)
% THE FINAL STEP PERMUTATION FOR DES
%   Tips: The input must be a vector.

load FPmatrix.mat FP


output = zeros(1,64);

for i = 1:64
    realIndex = FP(i);
    output(realIndex) = in(i);
end

result = output;
