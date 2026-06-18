% periodogram_oscillation_demo.m
% gurultulu sinyallerde periodogramun dalgali yapisini gosterir.
clc; clear; close all

% ornek sinyal
fs = 1000;
t_suresi = 4;
t = (0:1/fs:t_suresi-1/fs)';
kn = 0.8; % gurultu carpani, bu degeri degistirerek deneyebilirsiniz
% 50 hz + 150 hz + gurultu
x = sin(2*pi*50*t) + 0.5*sin(2*pi*150*t) + kn*randn(size(t));

% periodogram ile psd hesabi
[pxx, f] = periodogram(x, [], [], fs);

% gorsellestirme
figure('color', [1 1 1]);
plot(f, 10*log10(pxx), 'linewidth', 1.1)
grid on
xlabel('frekans (hz)')
ylabel('psd (db/hz)')
title('periodogram psd: dalgali tahmin')
xlim([0 250])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/periodogram_oscillation_demo.png');
