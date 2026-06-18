% welch_comparison_demo.m
% gurultulu bir sinyal icin periodogram ve welch psd yontemlerini karsilastirir.
clc; clear; close all

% ornek sinyal
fs = 1000;
t_suresi = 4;
t = (0:1/fs:t_suresi-1/fs)';
kn = 0.8; % gurultu carpani
x = sin(2*pi*50*t) + 0.5*sin(2*pi*150*t) + kn*randn(size(t));

% periodogram psd
[pxx_per, f_per] = periodogram(x, [], [], fs);

% welch psd parametreleri
winLength = 512; % segment uzunlugu
win = hann(winLength); % hann penceresi
overlap = round(0.50 * winLength); % %50 ortusme
nfft = 1024; % her segment icin fft uzunlugu

% welch psd hesabi
[pxx_welch, f_welch] = pwelch(x, win, overlap, nfft, fs);

% gorsellestirme
figure('color', [1 1 1]);
plot(f_per, 10*log10(pxx_per), 'color', [0.7 0.7 0.7], 'linewidth', 1.0); hold on
plot(f_welch, 10*log10(pxx_welch), 'b', 'linewidth', 1.4);
grid on
xlabel('frekans (hz)')
ylabel('psd (db/hz)')
title('periodogram ve welch psd karsilastirmasi')
legend('periodogram', 'welch')
xlim([0 250])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/welch_psd_comparison.png');
