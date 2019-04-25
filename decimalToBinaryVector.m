function out = decimalToBinaryVector(x, varargin)

out = dec2bin(x) - '0';

if (~isempty(varargin))
    required_length = varargin{1};
    if (required_length < size(out,2))
        error("the input length should must be greater than original length.")
    else
        len_diff = required_length - size(out,2);
        out = [zeros(size(out,1), len_diff), out];
    end
end

