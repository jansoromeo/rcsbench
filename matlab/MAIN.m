%% Main script to call PlayBackRCSSignal.m
close all; clear all; clc


%% name of AUDIO device
% devName = 1; -> 'neuroDAC'
% devName = 2; -> 'Studio 26c'
devName = 1;
calibrate = 0;
GP = 1;
STN = 0;
playSound = 0;

if devName == 1
    devName = 'MCHStreamer DAC8 ';
elseif devName == 2
    devName = 'Studio 26c';
end


%% load data
if calibrate
    % create sinewave and play sound
    f=20;
    A=0.0001;
    fs = 1000;
    T=10;
    [t, y, fs] = getCalibrateSinus(A,f,fs,T);
    if playSound
        sound(y,fs);
        disp('playing sound...')
        pause(T)
    end
    tdCh0 = y';

else
    if GP
        tdData = load('RawDataTD_GP_Offmeds.mat');
    elseif STN
        tdData = load('RawDataTD_RCS05_SelfT.mat');
    end
    tdCh0 = tdData.outdatcomplete.key0;
    fs = tdData.outdatcomplete.samplerate(1);
end

%% Create audio device object and connect to 100NeuroDAC
deviceWriter = audioDeviceWriter;
audioDevs = getAudioDevices(deviceWriter);
devWriter = setAudioDev(audioDevs,devName);

%% Create audio device reader
% deviceReader = audioDeviceReader;
% audioDevs = getAudioDevices(deviceReader);
% devReader = setAudioDev(audioDevs,devName);

%% create audio file from time domain signal
audioOut(tdCh0,1,length(tdCh0),fs,1,'rcsSig.wav');

%% load signal and play it via deviceWriter
fileReader = dsp.AudioFileReader('rcsSig.wav');
fileInfo = audioinfo('rcsSig.wav');
audioReader = dsp.AudioRecorder;
totalUnderrun = playBackRCSsignal(fileInfo, fileReader,audioReader);

function [t, y, fs] = getCalibrateSinus(A,f,fs,T)
ts=1/fs;
t=0:ts:T;
y=sin(2*pi*f*t);
end