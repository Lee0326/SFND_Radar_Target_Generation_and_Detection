clear all;
clc;

% The range resolution = 1m
% The speed of light c = 3*10^8

%% Range estimation
% TODO : Find the Bsweep of chirp for 1 m resolution
c = 3*10^8;
delta_r = 1;
Bsweep = c/2*delta_r;

% TODO : Calculate the chirp time based on the Radar's Max Range
range_max = 300;            % The radar maximum range = 300m  
Ts = 5.5*(range_max*2/c);   % 5.5 times of the trip time for maximumrange

% TODO : define the frequency shifts 
beat_freq = [0 1.1e6 13e6 24e6];   % given beat frequencies for all four targets
calculated_range = c*Ts*beat_freq/(2*Bsweep);  %range calculation

%display the calculate range
disp(calculated_range);

%% Doppler Velocity Calculation
c = 3*10^8;         %speed of light
frequency = 77e9;   %frequency in Hz

% TODO : Calculate the wavelength
wavelength = c/frequency;

% TODO : Define the doppler shifts in Hz using the information from above 
doppler_shift = [3e3 -4.5e3 11e3 -3e3];

% TODO : Calculate the velocity of the targets  fd = 2*vr/lambda

Vr = doppler_shift*wavelength/2;

% TODO: Display results
disp(Vr);

%% FFT Practice
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

% TODO: Form a signal containing a 77 Hz sinusoid of amplitude 0.7 and a 43Hz sinusoid of amplitude 2.
S = 0.7*sin(2*pi*77*t) + 2*sin(2*pi*43*t);

% Corrupt the signal with noise 
X = S + 2*randn(size(t));

% Plot the noisy signal in the time domain. It is difficult to identify the frequency components by looking at the signal X(t). 
plot(1000*t(1:50) ,X(1:50));
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

% TODO : Compute the Fourier transform of the signal. 
Y = fft(X);
% TODO : Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
P2 = abs(Y/L);
P1 = P2(1:L/2+1);

% Plotting
figure;
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%% 2-D Transform
% The 2-D Fourier transform is useful for processing 2-D signals and other 2-D data such as images.
% Create and plot 2-D data with repeated blocks.

P = peaks(20);
X = repmat(P,[5 10]);
imagesc(X)

% TODO : Compute the 2-D Fourier transform of the data.  
% Shift the zero-frequency component to the center of the output, and 
% plot the resulting 100-by-200 matrix, which is the same size as X.
Y = fft2(X);
imagesc(abs(fftshift(Y)))
