% stft_chirp_demo.m
% frekansi zamanla degisen bir chirp sinyali uzerinde stft uygulamasini gosterir.
clc; clear; close all

% chirp sinyali: frekans zamanla artiyor
fs = 1000;
t = (0:1/fs:2-1/fs)';
x = chirp(t, 50, t(end), 200); % 50 hz ile baslar, 200 hz ile biter

% stft / spektrogram parametreleri
winLength_stft = 128; % pencere uzunlugu
overlap_stft = 64; % %50 ortusme
nfft_stft = 256; % fft uzunlugu

% spektrogram cizimi
figure('color', [1 1 1]);
spectrogram(x, hann(winLength_stft), overlap_stft, nfft_stft, fs, 'yaxis');
title('chirp sinyali spektrogrami');
colorbar;
xlabel('zaman (s)');
ylabel('frekans (khz)');

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/stft_chirp_spectrogram.png');
