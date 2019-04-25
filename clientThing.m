function [PrivateKey, TXT, ret_KEY] = clientThing(TrueRandom, I_notation)

arduino_serial = serial('/dev/cu.usbmodem143401','BaudRate', 19200,...
    'DataBits', 8, 'Terminator', 'CR');

sram_vec = [];
TXT = input('input ur user ID:  ', 's');
fopen(arduino_serial);
pause(1);

fprintf(arduino_serial, '%s', '2');
pause(1);
for index = 1:16
    read_line_temp = fscanf(arduino_serial);
    read_line_temp = strtrim(read_line_temp);
    read_line_temp = appendzerosFromRead(read_line_temp);
    read_line_temp = strrep(read_line_temp, ' ', '');
    read_line_vector = hexToBinaryVector(read_line_temp, length(read_line_temp)*4);
    sram_vec = [sram_vec, read_line_vector];
    fprintf("           %s\n", read_line_temp);
end

fprintf("\n");
pw = input('Input the password!!!  :   ','s');
pw = DataHash(pw, 'SHA-512','hex','array');
pw = hexToBinaryVector(pw, 512);
AddressList = DataHash(binaryVectorToHex(xor(TrueRandom, pw)),'SHA-512','hex','array');
AddressList = hexToBinaryVector(AddressList, 512);
sram_mat = reshape(sram_vec,[64,64])';
Cipher = zeros(32,16);
fclose(arduino_serial);

for index = 1:32
    subAddressList = AddressList(16*index - 15:16*index);
    for indexx = 1:16
        [Cipher(index, indexx), op] = access_Cell(subAddressList, sram_mat);
        subAddressList = instructionOp(subAddressList,op);
    end
end

Cipher = reshape(Cipher',[1,512]);
maskList = xor(I_notation, AddressList);

xorResults = xor(Cipher, maskList);

PrivateKey = xorResults(1:2:end);

ret_KEY = binaryVectorToHex(PrivateKey);
end

function [ret_val, op] = access_Cell(subAddressList, sram_mat)
add_x = bi2de(subAddressList(1:6)) + 1;
add_y = bi2de(subAddressList(7:12)) + 1;
ret_val = sram_mat(add_x,add_y);
if (add_x + 1 > 64)
    temp = 1;
else
    temp = add_x + 1;
end

op = strrep(num2str([ret_val, sram_mat(temp,add_y)]),' ','');
end


function new_sub_add = instructionOp(subAddressList,op)
switch op
    case '00'
        new_sub_add = bitsshiftright(subAddressList,1);
    case '01'
        new_sub_add = bitsshiftleft(subAddressList, 1);
    case '10'
        new_sub_add = circshift(subAddressList, 7);
    case '11'
        new_sub_add = circshift(subAddressList, -10);
end
end

function appendedLine = appendzerosFromRead(read_line)
read_line = [[' ', read_line], ' '];
indexs = find(read_line == ' ');
shift = 0;
addset = [];
for indexx = 1:numel(indexs(1:end-1))
    indexTemp = indexs(indexx);
    counter = 0;
    while(read_line(indexTemp+1) ~= ' ')
        counter = counter + 1;
        indexTemp = indexTemp + 1;
    end
    
    if counter < 2
        addset = [addset, indexs(indexx) + shift];
        shift = shift + 1;
    end
end

for tt = 1:numel(addset)
    read_line = insertAfter(read_line, addset(tt), '0');
end

appendedLine = strtrim(read_line);
end

