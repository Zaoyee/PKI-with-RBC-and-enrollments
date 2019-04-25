function out = fFunction(R, n, rawKey)
%THE FFUNCTION WHICH IS USED IN THE ENCRYPTION

% Expansion permutation
load Expansionmatrix.mat E

expM = zeros(8,6);

for i = 1:length(R)
    [row, col] = find(E == i);
    for j = 1: length(row)
        expM(row(j), col(j)) = R(i);
    end
end

expM = expM';
expM = expM(:)';

% % Generate Kn based on function keyProcessor
% rawKey = randi([0 1], 1, 64);

% rawKey = "0E329232EA6D0D73";
% rawKey = mod(dec2bin(hex2dec(rawKey), 64), 2);

% rawKey = '00010011 00110100 01010111 01111001 10011011 10111100 11011111 11110001';
% rawKey = mod(strrep(rawKey, ' ', ''), 2);
K = keyProcessor(rawKey, n);


% XOR Kn and ExoansionMatrix Rn-1
Box = xor(expM, K);


% S-Box Substitution.
load 'SboxMatrices.mat'

%   Sperate into 8 small S box.
[Left, Right] = sperateHalf(Box);
[LeftLeft, LeftRight] = sperateHalf(Left);
[RightLeft, RightRight] = sperateHalf(Right);
[S1bits, S2bits] = sperateHalf(LeftLeft);
[S3bits, S4bits] = sperateHalf(LeftRight);
[S5bits, S6bits] = sperateHalf(RightLeft);
[S7bits, S8bits] = sperateHalf(RightRight);


%   find the information according to the Sbox;
[row, col] = checkSboxCoordin(S1bits);
so(1,1:4) = mod(dec2bin(S1(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S2bits);
so(2,1:4) = mod(dec2bin(S2(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S3bits);
so(3,1:4) = mod(dec2bin(S3(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S4bits);
so(4,1:4) = mod(dec2bin(S4(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S5bits);
so(5,1:4) = mod(dec2bin(S5(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S6bits);
so(6,1:4) = mod(dec2bin(S6(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S7bits);
so(7,1:4) = mod(dec2bin(S7(row + 1, col + 1), 4), 2);

[row, col] = checkSboxCoordin(S8bits);
so(8,1:4) = mod(dec2bin(S8(row + 1, col + 1), 4), 2);

Sout = zeros(1, 32);

for k = 1:8
    Sout(4*k-3: 4*k) = so(k,:);
end


% P-Box Permutation

load Pboxmatrix.mat P

out = zeros(4, 8);
for m = 1:32
    [row, col] = find(P == m);
    out(row, col) = Sout(m);
end

out = out';
out = out(:)';

    