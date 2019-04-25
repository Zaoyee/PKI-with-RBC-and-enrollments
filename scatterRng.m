function scatterRng()
    
% arduino_serial = serial('/dev/cu.usbmodem14201','BaudRate', 19200,...
%     'DataBits', 8, 'Terminator', 'CR');
% 
% fopen(arduino_serial);
% pause(1);
% 
% fprintf(arduino_serial, '%s', '1');
% pause(1);
% 
% TrueRandom = trueNumGen(arduino_serial);
Trialtimes = 100000;
sc = zeros(Trialtimes,2);

for index = 1:Trialtimes
    tempX = zeros(1,8);
    for indexx = 1:15
        tempX(indexx) = randi([0,1]);
    end
    
    tempY = zeros(1,8);
    for indexx = 1:15
        tempY(indexx) = randi([0,1]);
    end
    
    sc(index,:) = [bi2de(tempX), bi2de(tempY)];
end

scatter(sc(:,1),sc(:,2),'.');