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
        cprintf('UnterminatedStrings', [' ', bin_KEY_h(badHere(index))]);
        start = badHere(index) + 1;
    end
    fprintf("%s\n\n", bin_KEY_h(start:end));
    
    start = 1;
    for index = 1:numel(badHere)
        fprintf("%s", bin_an_KEY_h(start:badHere(index)-1));
        cprintf('UnterminatedStrings', [' ', bin_an_KEY_h(badHere(index))]);
        start = badHere(index) + 1;
    end
    fprintf("%s\n\n", bin_an_KEY_h(start:end));
    
    fprintf("There is/are %d bad bits.....\n\n", bad_bits);
    fprintf("*************************************************\n")
         
    