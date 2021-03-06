%% neuroDAC_testing.m
% a test bench environment for neuroDAC system from collaborators at Brown university
% Input parameters
%   - showScope
%   - amplitudeSweep
%   - ... other?

%% Close, clean environment
close all; clear all; clc;

%% Create oscillator type object
osc = audioOscillator;

%% Initialize bursting seq variables
osc.Frequency = 20;

% dataReal = load('RawDataTD.mat')
% dataRealCh = dataReal.outdatcomplete.key0;
% dataRealCh = dataRealCh(400:911);

% 0.005 < osc.Amplitude < 1
% Note the values below are rough, single picked values on a test data set
% (they are representative on order of magnitude)
% balanced R 1K
% osc.Amplitude = 1.0 -> 83 uV-peak, balanced R 1K
% osc.Amplitude = 0.7 -> 50 uV-peak, balanced R 1K
osc.Amplitude = 1;
scaleAmplitudFactor = 0.7;
interBurstInterval_s = 2;
numberBursts = 8;
durationBurstAU = 125; % units not yet worked out, defines duration of main burst
numSubBurst = 5;    % number of subbursts with changing amplitude witin main burst

%% Initialize session input parameters
outVoltAmpSweep = 1;
maxBurstAmplitude = 1; % approx 100 uVpeak in balanced RCS input amplifier (not yet accurate scaling,TO BE DONE!)
showScope = 0;

%% Initialize loop variables
cycleCount = 0;

%% Create audio device object and connect to 100NeuroDAC
deviceWriter = audioDeviceWriter;
devicesW = getAudioDevices(deviceWriter);

for j=1:length(devicesW)
    if strcmp('Studio 26c',char(devicesW(j)))
%     if strcmp('MCHStreamer DAC8 ',char(devicesW(j)))
        deviceName = char(devicesW(j));
        disp(['device (', deviceName, ') found! ...'])
        deviceWriter = audioDeviceWriter('Device', deviceName);
        break
    else
        if j==length(devicesW)
            disp('device not found, make sure U-DAC8 device is connected')
            break
        end
    end
end

%% Scope to visualize the variable-frequency sine wave generated by the audio oscillator
scope = dsp.TimeScope( ...
    'SampleRate',osc.SampleRate, ...
    'TimeSpan',0.05, ...
    'YLimits',[-1.5,1.5], ...
    'TimeSpanOverrunAction','Scroll', ...
    'ShowGrid',true, ...
    'Title','Variable-Frequency Sine Wave');

%% Loop for cycleCount and generate output voltage througjh deviceWriter
disp('Oscillation being delivered ...')
disp(['Frequency = ', num2str(osc.Frequency),' Hz'])
disp(['Amplitude = ', num2str(osc.Amplitude),' au'])

devWriterCount = 0;
while cycleCount < numberBursts
    pause(interBurstInterval_s);
    disp(strcat('burst number: ',num2str(cycleCount)))
    tic
    cycleCount = cycleCount + 1;
        while (devWriterCount < durationBurstAU)
            devWriterCount = devWriterCount + 1;
            pause(0.01);
            sineWave = scaleAmplitudFactor*osc();
            if showScope
                scope(sineWave);
            end
            deviceWriter(sineWave);
            if mod(devWriterCount,numSubBurst)==0                
                if outVoltAmpSweep
                    osc.Amplitude = osc.Amplitude - 0.2;
                    if osc.Amplitude < 0.01
                        osc.Amplitude = maxBurstAmplitude;
                    end
                end
            end
        end
    devWriterCount = 0;
    toc
end

%% Countdown for last off bursting segment of experiment
countDown = interBurstInterval_s;
while countDown > 0
    countDown = countDown - 1;
    pause(1)
    disp(strcat('Counting down, stop measurement in... ', num2str(countDown),' seconds'))
end 

disp('Bursting finshed!!!!')
