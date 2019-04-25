function enroll_mainRBCThing(t)

mask_mat = enroll_Process(t);   %% Actually a vector here, for mask.

[TrueRandom, I_notation, finalEncrptedTXT, KEY] = serverThing_again(mask_mat);

fprintf("\nThe True encrpted message is that : %s\n", finalEncrptedTXT);

fprintf("\nPlease unplug power for arduino for at least 5 second..........\n");
pause(10);
fprintf("Did u re-plug the power for arduino.........\n y/n");
aswr = input(":",'s');

if (aswr == "y")
    
    [PrivateKey, TXT, an_KEY] = clientThing_again(TrueRandom, I_notation, mask_mat);
    
    compareKEY(KEY, an_KEY)
    fprintf("Currently, it is running RBC engine.....\n")
    input("y/n:\n",'s');
    hexTXT = makeasciiToHex(TXT);
    n_fake_bits = 0;
    while(1)
        fprintf("Tring all the %d bad bits possibilties.....\n", n_fake_bits);
        trial_times_comb = nchoosek(1:192, n_fake_bits);
        
        for index = 1:size(trial_times_comb,1)
            fprintf("Tring the bad bits on %s\n", mat2str(trial_times_comb(index,:)));
            temp_P_Key = PrivateKey;
            temp_P_Key(trial_times_comb(index,:)) = ...
                temp_P_Key(trial_times_comb(index,:))*-1 + 1;
            temp_P_Key = binaryVectorToHex(temp_P_Key);
            trialEncrptedTXT = DESTTTriple(hexTXT, temp_P_Key);
            if (trialEncrptedTXT == finalEncrptedTXT)
                break;
            end
        end
        
        if (trialEncrptedTXT == finalEncrptedTXT)
            fprintf("the real Private Key found ... is that:\n%s\n", temp_P_Key)
            break;
        else
            fprintf("Tring all the %d bad bits possibilties FAILED..... :( \n", n_fake_bits);
        end
        n_fake_bits = n_fake_bits + 1;
    end
end
end


function hexTXT = makeasciiToHex(TXT)
ascii = double(TXT);
bin_ascii = decimalToBinaryVector(ascii, 8);
bin_ascii = bin_ascii';
bin_ascii = bin_ascii(:)';
hexTXT = binaryVectorToHex(bin_ascii);

end

function compareKEY(KEY, another_Key)
bin_KEY_h = KEY(1:48);
bin_an_KEY_h = another_Key(1:48);
bin_KEY = hexToBinaryVector(bin_KEY_h, 192);
bin_an_KEY = hexToBinaryVector(bin_an_KEY_h, 192);
bad_bits = numel(find((bin_KEY ~= bin_an_KEY) == 1));
badHere = find((bin_KEY_h ~= bin_an_KEY_h) == 1);
fprintf("*************************************************\n")
start = 1;
for index = 1:numel(badHere)
    fprintf("%s", bin_KEY_h(start:badHere(index)-1));
    cprintf('UnterminatedStrings', bin_KEY_h(badHere(index)));
    start = badHere(index) + 1;
end
fprintf("%s\n\n", bin_KEY_h(start:end));

start = 1;
for index = 1:numel(badHere)
    fprintf("%s", bin_an_KEY_h(start:badHere(index)-1));
    cprintf('UnterminatedStrings', bin_an_KEY_h(badHere(index)));
    start = badHere(index) + 1;
end
fprintf("%s\n\n", bin_an_KEY_h(start:end));

fprintf("There is/are %d bad bits.....\n\n", bad_bits);
fprintf("*************************************************\n")

end


function mask_mat = enroll_Process(times)

mask_mat = zeros(1,4096);
for index = 1: times
    fprintf("\nPlease unplug power for arduino for at least 5 second..........\n");
    pause(10);
    fprintf("Did u re-plug the power for arduino.........\n y/n");
    aswr = input(":",'s');
    
    if (aswr == "y")
        arduino_serial = serial('/dev/cu.usbmodem143401','BaudRate', 19200,...
            'DataBits', 8, 'Terminator', 'CR');
        fopen(arduino_serial);
        pause(1);
        eval(['fprintf("This is the ' num2str(index) ' times enrollment..\n");']);
        fprintf(arduino_serial, '%s', '2');
        pause(1);
        sram_vec = [];
        for indexx = 1:16
            read_line_temp = fscanf(arduino_serial);
            read_line_temp = strtrim(read_line_temp);
            read_line_temp = appendzerosFromRead(read_line_temp);
            read_line_temp = strrep(read_line_temp, ' ', '');
            read_line_vector = hexToBinaryVector(read_line_temp, length(read_line_temp)*4);
            sram_vec = [sram_vec, read_line_vector];
            fprintf("           %s\n", read_line_temp);
        end
        fprintf("\n\n");
        fclose(arduino_serial);
    end
    
    if (index == 1)
        temp_sram_vec = sram_vec;
    else
        mask_mat = mask_mat | (temp_sram_vec & sram_vec);
        temp_sram_vec = sram_vec;
    end
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

