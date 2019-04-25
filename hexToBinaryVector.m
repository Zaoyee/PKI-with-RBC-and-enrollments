function out = hexToBinaryVector(x, varargin)

out = dec2bin(hex2dec(x)) - '0';

if length(x) <= 8
    if (~isempty(varargin))
        required_length = varargin{1};
        if (required_length < size(out,2))
            error("the input length should must be greater than original length.")
        else
            len_diff = required_length - size(out,2);
            out = [zeros(size(out,1), len_diff), out];
        end
    end
else
    len = length(x);
    numChunk = len / 8;
    moreHex = mod(len, 8);
    realout = [];
    if (~isempty(varargin))
        required_length = varargin{1};
        if (required_length < length(out))
            error("the input length should must be greater than original length.")
        else
            for index = 1:numChunk
                realout = [hexToBinaryVector(x(len-8*index+1:len-(index-1)*8), 32), realout];
            end
            
            realout = [hexToBinaryVector(x(1:moreHex), required_length-32*numChunk), realout];           
            out = realout;
        end
    end
end
