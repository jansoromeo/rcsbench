function totalUnderrun = playBackRCSsignal(fileInfo, fileReader)
%% inputs, fileInfo and fileReader with RCS signal data from .wav format

deviceWriter = audioDeviceWriter('SampleRate',fileInfo.SampleRate);
setup(deviceWriter,zeros(fileReader.SamplesPerFrame,fileInfo.NumChannels));

disp(strcat('number of channels:',num2str(fileInfo.NumChannels)))
disp(strcat('duration of signal:', num2str(fileInfo.Duration),' seconds'))

totalUnderrun = 0;
while ~fileReader.isDone
    nextAudioFrame = fileReader.step;
    disp('running next frame')
    numUnderrun = deviceWriter(nextAudioFrame);
    totalUnderrun = totalUnderrun + numUnderrun;
end

fprintf('Total samples underrun: %d.\n',totalUnderrun);
fprintf('Total seconds underrun: %d.\n',double(totalUnderrun)/double(deviceWriter.SampleRate))

release(fileReader)
release(deviceWriter)

end


