function [i, mat] = recProcess(mat, audio, a, recObj, i, jpgfiles, F, W1, W2)
    if isempty(mat)
        mat = audio;
        turnOffLED(a);
    elseif length(audio) > 1000000             % Start over after
        stop(recObj)                           % 1,000,000 samples (45 sec)
        record(recObj);
        pause(1);
        audio = getaudiodata(recObj);
        mat = audio;
    else                                       % Store only new values
        mat = [];                              % with a window of 7718
        mat = audio(length(audio)-7718:length(audio));  % samples (350ms)
        X = TestSpecSave(jpgfiles);            % Save and Load Spectrogram
        i = TestSpecCNN(X, F, W1, W2);         % Conv Neural Network
    end
    if sum(mat) == 0 || nnz(~mat) > 7100       % If mostly is silence
        mat(1:length(mat)) = .1;
        i = 6;
    end
end