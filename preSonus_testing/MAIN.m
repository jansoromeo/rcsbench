%% Main script to call PlayBackRCSSignal.m
close all; clear all; clc

%% name of AUDIO device
% name 1: 'Studio 26c'
devName = 'Studio 26c';
devName = 'MCHStreamer DAC8 ';
%% load data
tdData = load('RawDataTD_RCS05_SelfT.mat');
tdCh0 = tdData.outdatcomplete.key0;
sr = tdData.outdatcomplete.samplerate(1);

%% Create audio device object and connect to 100NeuroDAC
deviceWriter = audioDeviceWriter;
audioDevs = getAudioDevices(deviceWriter);
devWriter = setAudioDevWriter(audioDevs,devName);

% create sinewave and play sound
% [t, y, fs] = playSound();
% disp('playing sound...')
% pause(5)

%% create audio file from time domain signal
audioOut(tdCh0,1,length(tdCh0),sr,1,'rcsSig.wav');

%% load signal and play it via deviceWriter
fileReader = dsp.AudioFileReader('rcsSig.wav');
fileInfo = audioinfo('rcsSig.wav');
totalUnderrun = playBackRCSsignal(fileInfo, fileReader);

function [t, y, fs] = playSound()
f=20;
Amp=1;
fs = 1000;
ts=1/fs;
T=10;
t=0:ts:T;
y=sin(2*pi*f*t);
sound(y,fs);
end