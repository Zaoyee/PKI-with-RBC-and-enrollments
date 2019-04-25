function out = SHA2(plaintext)
% The main function of Secure hash algorithm

operatedmessage = appendmessage(plaintext);

out = sha2operation(operatedmessage);
sha