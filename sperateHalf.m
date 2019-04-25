function [L, R] = sperateHalf(in)
% THIS FUNCTION IS APPLIED TO SPERATE ANYTHING INTO HALF.

L = in(1:end/2);
R = in(end/2+1:end);