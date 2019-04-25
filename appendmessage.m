function message = appendmessage(plaintext)

Plaintext = plaintext;
Plaintext = double(Plaintext);
text = decimalToBinaryVector(Plaintext,8);
text = text';
message = reshape(text, 1, []);
l = length(message);

% if l > 55 * 8
%     message = message(1:447);
% end

% Append a 1 It means the start of appending;
message = [message, 1];

% Starting append multiple(0 to 512 bits) 0s to make sure resulting message
% length is congruent to 448 = -64 mod 512

for i = 1: 512
    
    if (mod(length(message), 512) == mod(-64, 512))
        break;
    end
    
    message = [message, 0];
    
end


appendlength = decimalToBinaryVector(l, 64);

message = [message, appendlength];
tempmessage = message;


% Sperate message into multiple 512 chunks.
n = length(tempmessage) / 512;
message = zeros(n, 512);

for i = 1:n
    message(i,:) = tempmessage(512 *(i-1) + 1: 512*i);
end

% disp(Plaintext)