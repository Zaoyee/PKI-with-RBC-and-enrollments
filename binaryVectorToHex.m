function out = binaryVectorToHex(x)

if (length(x) <= 52)
    out = dec2hex(bin2dec(char(x + '0')));
else
    chunkNum = floor(length(x) / 52);
    remainder = mod(length(x), 52);
    out = '';
    len = length(x);
    for index = 1:chunkNum
        tempstr = dec2hex(bin2dec(char(x((len-52*index+1):(len-52*(index-1))) + '0')));
        out = strcat(tempstr, out);
    end
    out = strcat(dec2hex(bin2dec(char(x(1:remainder) + '0'))), out);
end