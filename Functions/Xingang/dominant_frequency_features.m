function [maxfre,maxval] = dominant_frequency_features(x)
% ******************************************************* %
% x --- senquence to processing
% maxfre --- maximum frequency 
% maxval --- maximum magnitude 
% ******************************************************* %
% Author: Xingang
% Date: 27/03/2018

% Intial values
fs = 1;
Nf = 2^16; 
Ts=1/fs;
x = x - mean(x);
% Discrete Fourier Transform
y=fft(x);
% points in the FFT
y=fft(x,Nf);
z = fftshift(y);
% raw power spectrum density
y = abs(y.^2); 
% half-spectrum
y = y(1:1+Nf/2); 
% find maximum
[v,k] = max(y); 
% frequency scale
f_scale = (0:Nf/2)* fs/Nf; 
% dominant frequency estimate
maxfre = f_scale(k); 
maxval = y(k);
end


