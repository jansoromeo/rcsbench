function totalUnderrun = playBackRCSsignal(fileInfo, fileReader,audioReader)
%% inputs, fileInfo and fileReader with RCS signal data from .wav format

deviceWriter = audioDeviceWriter('SampleRate',fileInfo.SampleRate);
setup(deviceWriter,zeros(fileReader.SamplesPerFrame,fileInfo.NumChannels));

% deviceReader = audioDeviceReader('SampleRate',fileInfo.SampleRate);
% setup(deviceReader,zeros(fileReader.SamplesPerFrame,fileInfo.NumChannels));
% recObj = audiorecorder(8000,16,1);  

disp(strcat('number of channels:',num2str(fileInfo.NumChannels)))
disp(strcat('duration of signal:', num2str(fileInfo.Duration),' seconds'))

totalUnderrun = 0;
% fid = fopen('recordFile.txt','w')
while ~fileReader.isDone
    nextOutputFrame = fileReader.step;
    disp('running next frame')
    numUnderrun = deviceWriter(nextOutputFrame);
    totalUnderrun = totalUnderrun + numUnderrun;
%     nextInputFrame = audioReader.step;
% %%Create a timer object:
% set(recObj,'TimerPeriod',0.01,'TimerFcn',@VADML); 
% a = record(recObj,1);
% fprintf(fid,a);

end

fprintf('Total samples underrun: %d.\n',totalUnderrun);
fprintf('Total seconds underrun: %d.\n',double(totalUnderrun)/double(deviceWriter.SampleRate))

release(fileReader)
release(deviceWriter)
release(audioReader)

end


