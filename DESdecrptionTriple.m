function plainText = DESdecrptionTriple(encrpytTXT, rawKey)
% The second step for triple DES decrption

text = hexToBinaryVector(encrpytTXT, 64);

text = DESpermInitial(text);
rawKey = hexToBinaryVector(rawKey, 64);

[R16, L16] = sperateHalf(text);

[L0, R0] = decrpt(L16, R16, 16, rawKey);


finalInput = [L0 R0];

output = DESpermFinal(finalInput);

plainText = binaryVectorToHex(output);

while length(plainText) ~= 16
    plainText = strcat('0', plainText);
end

%--------------------------------------------------------------------------
% Dispaly results;
fprintf('The DES encrpyted text:  %s\n  ',plainText);

