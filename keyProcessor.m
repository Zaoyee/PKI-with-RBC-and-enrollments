function Key = keyProcessor(rawKey, n)
% GENERATE THE KEY FOR CERTAIN N BASED ON the RAWKEY

if n > 16 || n < 1
    error(' The # of round should be in [1, 16]')
end

% The first permuted choice 1
load PC1matrix.mat PC1
load PC2matrix.mat PC2

Key = zeros(8,7);

for k = 1:length(rawKey)
    [row, col] = find(PC1 == k);
    
    if isempty(row) && isempty(col)
        continue
    end
    
    Key(row, col) = rawKey(k);
end
Key = Key'; Key = Key(:)';


[shiftLeft, shiftLeft2] = sperateHalf(Key);

% Begin shift
for i = 1:n
    if i == 1 || i == 2 || i == 9 || i == 16
        % Shift 1 bit if round is 1 or 2 or 9 or 16
        shiftLeft = circshift(shiftLeft, -1);
        shiftLeft2 = circshift(shiftLeft2, -1);
    else
        % Shift 2 bits
        shiftLeft = circshift(shiftLeft, -2);
        shiftLeft2 = circshift(shiftLeft2, -2);
    end
end

tempKey = [shiftLeft shiftLeft2];

Key = zeros(8,6);

for k = 1:length(tempKey)
    [row, col] = find(PC2 == k);
    
    if isempty(row) && isempty(col)
        continue
    end
    
    Key(row, col) = tempKey(k);
end

% Get the final key processor
Key = Key'; 
Key = Key(:)';


    