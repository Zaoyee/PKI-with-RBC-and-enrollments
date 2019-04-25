function [Srow, Scol] = checkSboxCoordin(Sin)
% Get the coordination of a S  

A = Sin(2:5);
Scol = A(1)*10^3 + A(2)*10^2 + A(3)*10 + A(4);
Scol = bin2dec(num2str(Scol));

B = [Sin(1), Sin(end)];
Srow = B(1)*10 + B(2);
Srow = bin2dec(num2str(Srow));
 

