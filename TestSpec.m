clear all

a = arduino('/dev/cu.usbmodem142201', 'Uno');
 
load('Variables.mat');

turnOffLED(a);
LED(a, whiteLED);

load('SirenConv.mat');

recObj = audiorecorder(22050,8,1,4);
record(recObj);
pause(1);  
audio = getaudiodata(recObj);

figure('Renderer', 'opengl', 'Position', [0 0 80 80])
maximizeWindow();
saveas(gcf,[pwd,'/0_spec','.jpg']);

while power == 0
    % Recording Process
    [i, mat] = recProcess(mat, audio, a, recObj, i, jpgfiles, F, W1, W2);
    
    % Trigger LED from results
    sirenLEDState = TriggerLED(i, sirenLEDState, o, greenLED, redLED, ...
        blueLED, a);
    
    % Button Functions
    power = sleepOnOff(power, a, greenLED, whiteLED, button);
    
    % Generate New Spectrogram
    createSpectrogram(mat);
    
    % Update Recording Variables
    pause(1/10);
    l = length(audio);          
    audio = getaudiodata(recObj);
end
turnOffLED(a);
stop(recObj);
close all