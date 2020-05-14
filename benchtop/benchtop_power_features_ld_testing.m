%% Script name: rcs_software_model

% 1) Aim 1: play around with LDs and power bands to figure ways of removing/supressing stim artifact from sensing
% 2) Aim 2: devlop a software where we can study performanc of aDBS using embedded properties and beyond, based on time domain signal
% Data in: domain LFP, Power bands, LDs, stim current, states
% Data out: best fitting linear model that has best performanc suppresing stim artifact
% 

% LD settings variables
% - UpdateRate
% - OsetDuration
% - TerminationDuration
% - BlankingDuraitonUponStateChange
% - NormalizationSubtractVector
% - NormalizationMultiplyVector
% - WeightVector
% - BiasTerm
% - FractionalFixedPointValue


close all; clear all; clc

featureLength = 1;
FractionalFixedPointValue = 0;
WeightVector = [1 0 0 0];
NormalizationMultiplyVector = [0 0 0 0];
NormalizationSubtractVector = [0 0 0 0 ];

%%% Example with perfect sinewave 20 Hz
Fs = 500;
f = 20;
A = 2;
T = 10;
[t, y, fs] = getSinewave(Fs,f,A,T);
figure
plot(t,y)

%% Compute fft of the signal with hann window

% Compute the Fourier transform of the signal.
L = length(y);
Y = fft(y);

%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%Define the frequency domain f and plot the single-sided amplitude spectrum P1. The amplitudes are not exactly at 0.7 and 1, as expected, because of the added noise. On average, longer signals produce better frequency approximations.
f = Fs*(0:(L/2))/L;
figure
subplot(211)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

[fftOut,ff]   = pwelch(y,Fs,Fs/2,0:1:Fs/2,Fs,'psd');
subplot(212)
plot(ff,fftOut,'r') 

%% Compute power of signal based on fft (output is FeaturePower)
fftRate = 50e-3;
fftpnts = 256;
f = Fs*(0:(fftpnts/2))/fftpnts;
figure
hold on
% running window fft of time domain and equivalent power
for ii=1:length(y)-fftpnts
    % Compute the Fourier transform of the signal.
    Y = fft(y(ii:ii+fftpnts));

    %Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
    P2 = abs(Y/fftpnts);
    P1 = P2(1:fftpnts/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    plot(f,P1,'o') 
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
end
    

%% Compare this power to the power of a signal from RCS


%% 
% FeaturePower = sin()
% i = 1 : featureLength;
% W(i) = (WeightVector(i)) / 2^FractionalFixedPointValue;
% M(i) 	= (NormalizationMultiplyVector(i)) / 2^FractionalFixedPointValue;
% ScaledFeaturePower(i) = W(i) * M(i) * (FeaturePower(i)-NormalizationSubtractVector(i));
% LDPowerOutput = sum (ScaledFeaturePower);
% 
% %% LDPowerOutput
% % compared to Lower and Upper threshold terms to determine if the output is ?low?, ?in-range?, or ?high? when using dual thresholds
% % With a single Threshold, the output states compare against only the LowerThreshold and are just ?low? or ?high?.
% 	LowerThreshold
% 		= (BiasTerm[1]) / 2^FractionalFixedPointValue 
% 
% 	UpperThreshold
% 		= (BiasTerm[2]) / 2^FractionalFixedPointValue 
        
function [t, y, fs] = getSinewave(fs,f,A,T)
ts=1/fs;
t=0:ts:T;
y=A*sin(2*pi*f*t);
% sound(y,fs);
end
