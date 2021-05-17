% This function transforms recorded RCS voltage sensing data 
% into an audio-compatible format
% Input data: sensing data as a table
% Output data: multi-channel wav file sampled at 8kHz, 16 BPS

%Author: maria.olaru@ucsf.edu

%Function parameters: 
%i = input table
%ir = start row
%er = end row
%sr = sampling rate (in Hz)
%c = number of channels
%o = full output filepath (recommended: .wav extension)

% audioOut(sine_output, 1, 4800000, 8000, 2, 'test.wav')

function audioOut(i, ir, er, sr, c, o)
    td_orig = i(ir:er, 1:c); %extract sub-sample of td data
%     td_orig = td_orig{:,:}; %convert to matrix format
    
    td = td_orig;
%     td(1:(sr*20),:) = []; %remove inital ramping artifact
    
%     tdf = filloutliers(td, 'linear', 'ThresholdFactor', 10); %interpolate outliers

%     tdfz = tdf - mean(tdf); %mean center
    tdfzi = resample(td, 8000/sr, 1); %interpolate for 8kHz sample rate
   
    scaleval = max(max(tdfzi),max(abs(tdfzi)));
    tdfzis = rescale(tdfzi, -32768, 32767, 'InputMin', -scaleval, 'InputMax', scaleval); %rescale for 16-bit signed int
    tdfzisb = int16(tdfzis); %change data type to 16-bit signed integer

    audiowrite(o, tdfzisb, 8000, 'BitsPerSample', 16);
end