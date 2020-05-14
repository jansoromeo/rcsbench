function out = setAudioDevWriter(audioDevs, name)
%% name is a string of the audio device name

for j=1:length(audioDevs)
    if strcmp(name,char(audioDevs(j)))
        deviceName = char(audioDevs(j));
        disp(['device (', deviceName, ') found! ...'])
        out = audioDeviceWriter('Device', deviceName);
        break
    else
        if j==length(audioDevs)
            disp('device not found, make sure U-DAC8 device is connected')
            break
        end
    end
end

end
