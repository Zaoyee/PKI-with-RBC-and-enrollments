function encrptoutput = DESencrptionTriple(PlainText, rawKey)
% The first step for triple DES encrption

text = hexToBinaryVector(PlainText, 64);

rawKey = hexToBinaryVector(rawKey, 64);

%       PlainText = randi([0 1], 1, 64);


% Dispaly the PlainText
%       disp(PlainText);

%text = num2str(PlainText);

%text = strrep(text, ' ', '');

% Initial Permuatation and make speratation 64bits to 2 32bits
inPerm = DESpermInitial(text);
[L0, R0] = sperateHalf(inPerm);

% Begining encrpytion
[LFinal, RFinal] = encrpt(L0, R0, 1, rawKey);

% Final Reversed Permutation
inputFinal = [RFinal LFinal];

result = DESpermFinal(inputFinal);
%
% [resultLeft, resultRight] = sperateHalf(result);
%
%
% resultstr1 = strrep(num2str(resultLeft), ' ', '');
% resultstr2 = strrep(num2str(resultRight), ' ', '');
%
%
% result1 = dec2hex(bin2dec(resultstr1), 8);
% result2 = dec2hex(bin2dec(resultstr2), 8);
%
% result = [result1, result2];

result = binaryVectorToHex(result);
while length(result) ~= 16
    result = strcat('0', result);
end
encrptoutput = result;
%-------------------------------------------------------------
% Dispaly results;
fprintf('The DES encrpyted text:  %s\n  ',result);





