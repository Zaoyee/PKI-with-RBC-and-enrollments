function finalEncrptedTXT = DESTTTriple(PlainText, rawKey)

% THE PROCESS AND THE RESULTS OF TRIPLE DES
while length(PlainText) ~= 16
    PlainText = strcat(PlainText,'0');
end
% The first step of triple DES--------encrption
encrptedTXT = DESencrptionTriple(PlainText, rawKey(1:16));

% The second step of triple DES---------decrption
decrptedTXT = DESdecrptionTriple(encrptedTXT, rawKey(17:32));

% The final step of triple DES--------encrption
finalEncrptedTXT = DESencrptionTriple(decrptedTXT, rawKey(33:48));


%-------------------------------------------------------------------------
% The final triple DES result
fprintf('The final triple DES encrpyted text:  %s  \n\n', finalEncrptedTXT);
