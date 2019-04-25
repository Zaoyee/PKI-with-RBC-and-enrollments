function hexTXT = makeasciiToHex(TXT)
ascii = double(TXT);
bin_ascii = decimalToBinaryVector(ascii, 8);
bin_ascii = bin_ascii';
bin_ascii = bin_ascii(:)';
hexTXT = binaryVectorToHex(bin_ascii);

end