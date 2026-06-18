% stft_window_effect.m
% pencere uzunlugunun spektrogram cozunurlugu uzerindeki etkisini gosterir.
clc; clear; close all

% chirp sinyali
fs = 1000;
t = (0:1/fs:2-1/fs)';
x = chirp(t, 50, t(end), 200); % 50 hz ile baslar, 200 hz ile biter

% kisa pencereli spektrogram
winShort = hann(64);
overlapShort = round(0.50 * length(winShort));
nfftShort = 256;

figure('color', [1 1 1]);
spectrogram(x, winShort, overlapShort, nfftShort, fs, 'yaxis');
title('kisa pencereli spektrogram');
colorbar;
xlabel('zaman (s)');
ylabel('frekans (khz)');
saveas(gcf, '../assets/stft_short_window.png');

% uzun pencereli spektrogram
winLong = hann(256);
overlapLong = round(0.50 * length(winLong));
nfftLong = 512;

figure('color', [1 1 1]);
spectrogram(x, winLong, overlapLong, nfftLong, fs, 'yaxis');
title('uzun pencereli spektrogram');
colorbar;
xlabel('zaman (s)');
ylabel('frekans (khz)');
saveas(gcf, '../assets/stft_long_window.png');
