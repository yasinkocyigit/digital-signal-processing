% welch_real_data_motor.m
% cwru motor titresim sinyalini welch psd kullanarak analiz eder.
clc; clear; close all

% cwru mat dosyasini oku
matfile = '../../data/B007_1_123.mat'; % cwru dosyanizin yolunu belirtin
S = load(matfile);

% drive end kanalini kullan
x = S.X123_DE_time;
% cwru verisi icin ornekleme frekansi
fs_motor = 48000;
% dc ofsetini cikar
x = x - mean(x);

% ilk 2 saniyeyi al
sure = 2;
n_motor = min(length(x), sure*fs_motor);
x = x(1:n_motor);
t_motor = (0:n_motor-1)/fs_motor;
fprintf("cwru verisi: fs=%d hz | n=%d | sure=%.2f s\n", fs_motor, n_motor, n_motor/fs_motor);

% motor verisi icin welch psd parametreleri
winLength_motor = 2048;
win_motor = hann(winLength_motor);
overlap_motor = round(0.50 * winLength_motor);
nfft_motor = 4096;

% motor verisi icin welch psd hesabi
[pxx_motor, f_motor] = pwelch(x, win_motor, overlap_motor, nfft_motor, fs_motor);

% gorsellestirme
figure('color', [1 1 1]);
subplot(2,1,1)
plot(t_motor, x, 'linewidth', 1.0)
grid on
xlabel('zaman (s)')
ylabel('ivme (keyfi birim)')
title('cwru motor titresimi - zaman alani')
xlim([0 0.05])

subplot(2,1,2)
plot(f_motor, 10*log10(pxx_motor), 'linewidth', 1.2)
grid on
xlabel('frekans (hz)')
ylabel('psd (db/hz)')
title('cwru motor titresimi - welch psd')
xlim([0 10000])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/welch_motor_psd.png');
