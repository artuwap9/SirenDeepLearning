% For the training process, it was recorded the sirens and horns applying 
% the following considerations:
%
% - Pure sound of siren/horn
% - Street Noise (cars)
% - People talking
% - Rain, wind
% - All W/(Pitch and Amplitude of Siren)
%
% There were 500 samples of each, making 2000 per category which are:
% 
% 1 = Ambulance Siren (Wail)
% 2 = Ambulance Siren (Yelp)
% 3 = Police Siren Type 1 (Hi-Lo)
% 4 = Police Siren Type 1 (Priority)
% 5 = Noise
%
% Making 10,000 samples in total.

clear all

load('RN0_10000.mat')           % Load random nombers from 1 to 10,000.

recObj = audiorecorder(22050,8,1,4); % 22.05k Sample Rate, 8Bits, Mono, Device.
mat = [];                       % Create Matrix which stores a range of samples
                                % of the recording
record(recObj);                 % Start Recording
pause(1);                       % To start it needs at least .5s of data (6/10)
audio = getaudiodata(recObj);   % Retrieve audio data and store it
a = 1;

figure('Renderer', 'opengl', 'Position', [0 0 80 80])
maximizeWindow();

while a <= 2000                     % Number of Spectrograms to be saved
    if isempty(mat)                 % If recording variable is empty
        mat = audio;
    elseif length(audio) > 1000000  % Start over after 1,000,000 samples
        stop(recObj)                % which is 45 secs
        record(recObj);
        pause(1);
        audio = getaudiodata(recObj);
        mat = audio;
    else                            % Pass new values and save
        mat = []; 
        mat = audio(l:l+7718);
        saveas(gcf,[pwd,'/images/5/',num2str(p(a)),'_5','.jpg']);
        a = a + 1;
        disp(a)
    end
    if sum(mat) == 0                % If audio is almost silent
        mat(1:7500) = .1;
    end
    
    createSpectrogram(mat);         % Generate Spectrogram
    pause(1/10);
    l = length(audio);              % Update New Recording Values
    audio = getaudiodata(recObj);
end
stop(recObj);
close all