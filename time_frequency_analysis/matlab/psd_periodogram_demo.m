% psd_periodogram_demo.m
% gurultulu bir sinyal icin periodogram ile temel psd kavramini gosterir.
clc; clear; close all

% ornek sinyal
fs = 1000;
t = (0:1/fs:2-1/fs)';
% 50 hz + 150 hz + gurultu
x = sin(2*pi*50*t) + 0.5*sin(2*pi*150*t) + 0.4*randn(size(t));

% tek tarafli fft sablonu
n_fft = length(x);
X = fft(x)/n_fft;
k_fft = floor(n_fft/2) + 1;
f_fft = (0:k_fft-1)*(fs/n_fft);
mag = abs(X(1:k_fft));
mag(2:end-1) = 2*mag(2:end-1);

% periodogram ile psd hesabi
[pxx, f_psd] = periodogram(x, [], [], fs);

% gorsellestirme
figure('color', [1 1 1]);
subplot(3,1,1)
plot(t, x, 'linewidth', 1.0)
grid on
xlabel('zaman (s)')
ylabel('genlik')
title('gurultulu sinyal - zaman alani')
xlim([0 0.2])

subplot(3,1,2)
plot(f_fft, mag, 'linewidth', 1.1)
grid on
xlabel('frekans (hz)')
ylabel('|X(f)|')
title('tek tarafli fft genlik spektrumu')
xlim([0 250])

subplot(3,1,3)
plot(f_psd, 10*log10(pxx), 'linewidth', 1.1)
grid on
xlabel('frekans (hz)')
ylabel('psd (db/hz)')
title('periodogram ile psd')
xlim([0 250])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/psd_periodogram_demo.png');
