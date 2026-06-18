% welch_parameter_effect.m
% segment uzunlugunun welch psd uzerindeki etkisini gosterir.
clc; clear; close all

% ornek sinyal
fs = 1000;
t_suresi = 4;
t = (0:1/fs:t_suresi-1/fs)';
x = sin(2*pi*50*t) + 0.5*sin(2*pi*150*t) + 0.8*randn(size(t));

% kisa segment ile welch psd
winLength1 = 256;
win1 = hann(winLength1);
overlap1 = round(0.50 * winLength1);
nfft1 = 1024;
[pxx1, f1] = pwelch(x, win1, overlap1, nfft1, fs);

% uzun segment ile welch psd
winLength2 = 1024;
win2 = hann(winLength2);
overlap2 = round(0.50 * winLength2);
nfft2 = 1024;
[pxx2, f2] = pwelch(x, win2, overlap2, nfft2, fs);

% gorsellestirme
figure('color', [1 1 1]);
plot(f1, 10*log10(pxx1), 'b', 'linewidth', 1.2); hold on
plot(f2, 10*log10(pxx2), 'r', 'linewidth', 1.2);
grid on
xlabel('frekans (hz)')
ylabel('psd (db/hz)')
title('welch psd: segment uzunlugunun etkisi')
legend('kisa segment: 256', 'uzun segment: 1024')
xlim([0 250])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/welch_segment_effect.png');
