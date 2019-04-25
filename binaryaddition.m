function out = binaryaddition(in1,in2)
% Add two binary input and get and vector result which has been limited num
% to show up

% out = bi2de(in1,'left-msb') + bi2de(in2,'left-msb');
% tempout = decimalToBinaryVector(out);

l = length(in1);

tempout = zeros(1,32);
flg = 0;

for i = l:-1:1
    addition = in1(i) + in2(i) + flg;
    
    realcal = mod(addition, 2);
    
    if addition >= 2
        flg = 1;
    else
        flg = 0;
    end

    tempout(i) = realcal;
    
end

out = tempout;