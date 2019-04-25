function out = sha2operation(message)
% More operation of Secure hash algorithm 256

[r,c] = size(message);


% About these hash constant num, It get from the first 8 prime number.
% Take the saqure root of these number, and extract the first 32 bits of
% the fraction part of these square root. Example: sqrt(2) =
% 0.4142135623730...., the H0 is the heximal of these 32 bits fraction.
H0 = '6a09e667';
H1 = 'bb67ae85';
H2 = '3c6ef372';
H3 = 'a54ff53a';
H4 = '510e527f';
H5 = '9b05688c';
H6 = '1f83d9ab';
H7 = '5be0cd19';

B0 = hexToBinaryVector(H0, 32);
B1 = hexToBinaryVector(H1, 32);
B2 = hexToBinaryVector(H2, 32);
B3 = hexToBinaryVector(H3, 32);
B4 = hexToBinaryVector(H4, 32);
B5 = hexToBinaryVector(H5, 32);
B6 = hexToBinaryVector(H6, 32);
B7 = hexToBinaryVector(H7, 32);


Key = { '428a2f98' '71374491' 'b5c0fbcf' 'e9b5dba5'
    '3956c25b' '59f111f1' '923f82a4' 'ab1c5ed5'
    'd807aa98' '12835b01' '243185be' '550c7dc3'
    '72be5d74' '80deb1fe' '9bdc06a7' 'c19bf174'
    'e49b69c1' 'efbe4786' '0fc19dc6' '240ca1cc'
    '2de92c6f' '4a7484aa' '5cb0a9dc' '76f988da'
    '983e5152' 'a831c66d' 'b00327c8' 'bf597fc7'
    'c6e00bf3' 'd5a79147' '06ca6351' '14292967'
    '27b70a85' '2e1b2138' '4d2c6dfc' '53380d13'
    '650a7354' '766a0abb' '81c2c92e' '92722c85'
    'a2bfe8a1' 'a81a664b' 'c24b8b70' 'c76c51a3'
    'd192e819' 'd6990624' 'f40e3585' '106aa070'
    '19a4c116' '1e376c08' '2748774c' '34b0bcb5'
    '391c0cb3' '4ed8aa4a' '5b9cca4f' '682e6ff3'
    '748f82ee' '78a5636f' '84c87814' '8cc70208'
    '90befffa' 'a4506ceb' 'bef9a3f7' 'c67178f2' };

Key = Key';
Key = Key(:)';

for i = 1:r
    
    C0 = B0;
    C1 = B1;
    C2 = B2;
    C3 = B3;
    C4 = B4;
    C5 = B5;
    C6 = B6;
    C7 = B7;
    
    for k = 1:16
        tempmess(k,:) =  message(i, 32*(k-1) + 1 : 32*k);
    end
    
    % Extend to 64 32-bits words
    for j = 17:64
        tempdata1 = tempmess(j - 15,:);
        tempdata2 = tempmess(j - 2,:);
        
        s0 = xor(circshift(tempdata1, 7 ,2), xor(circshift(tempdata1, 18 ,2), bitsshiftright(tempdata1, 3)));
        
        s1 = xor(circshift(tempdata2, 17, 2), xor(circshift(tempdata2, 19, 2), bitsshiftright(tempdata2, 10)));
        
        tempmess(j,:) = binaryaddition(binaryaddition(binaryaddition(tempmess(j - 16,:), s0), tempmess(j - 7,:)), s1);
    end
    
    for m = 1:64
        s0 = xor(xor(circshift(C0, 2), circshift(C0, 13)), circshift(C0, 22));
        mafunc = xor((C0 & C1), xor((C0 & C2), (C1 & C2)));
        T2 = binaryaddition(s0, mafunc);
        s1 = xor(xor(circshift(C4, 6), circshift(C4, 11)), circshift(C4, 25));
        chfunc = xor((C4 & C5),(~C4 & C6));
        T1 = binaryaddition(binaryaddition(binaryaddition(binaryaddition(C7, s1), chfunc), hexToBinaryVector(Key(m),32)), tempmess(m,:));
        C7 = C6;
        C6 = C5;
        C5 = C4;
        C4 = binaryaddition(C3, T1);
        C3 = C2;
        C2 = C1;
        C1 = C0;
        C0 = binaryaddition(T1, T2);
    end
    
    B0 = binaryaddition(C0, B0);
    B1 = binaryaddition(C1, B1);
    B2 = binaryaddition(C2, B2);
    B3 = binaryaddition(C3, B3);
    B4 = binaryaddition(C4, B4);
    B5 = binaryaddition(C5, B5);
    B6 = binaryaddition(C6, B6);
    B7 = binaryaddition(C7, B7);
    
end

out(1,:) = [B0 B1 B2 B3 B4 B5 B6 B7];
    