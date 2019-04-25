function out = trueNumGen_Gen()

Trialtimes = 100000;
sc = zeros(Trialtimes,2);

arduino_serial = serial('/dev/cu.usbmodem14201','BaudRate', 19200,...
    'DataBits', 8, 'Terminator', 'CR');

fopen(arduino_serial);
pause(1);

for index = 1:Trialtimes/16
    fprintf(obj, '%s', '1');
    pause(1);
    read = fscanf(obj);
    out = fscanf(obj);
    out = strcat(strtrim(read),strtrim(out));
    out = out - '0';
    
    
end