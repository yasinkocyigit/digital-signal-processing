% cwru motor titresim verisi ve smoothing
% bu script, motor titresim verisindeki gurultunun moving average 
% filtresi ile nasil azaltildigini gosterir.

clc; clear; close all;

% veri yukleme
file_path = fullfile('..', '..', 'data', 'B007_1_123.mat');
if ~exist(file_path, 'file')
    error('Motor veri dosyasi bulunamadi: %s', file_path);
end

data_struct = load(file_path);
% de (drive end) titresim kanalini seciyoruz
x = data_struct.X123_DE_time; 
Fs = 48000; % cwru ornekleme frekansi

% dc bilesenini temizleme (ortalama cikarma)
x = x - mean(x);

% moving average uygulama
M = 11;
h = ones(1, M) / M;
y = filter(h, 1, x);

% zaman domeni karsilastirmasi
t = (0:length(x)-1) / Fs;
N_show = round(0.05 * Fs); % ilk 0.05 saniye

fig1 = figure;
plot(t(1:N_show), x(1:N_show)); hold on;
plot(t(1:N_show), y(1:N_show), 'LineWidth', 1.2);
title('Motor Titresimi: Orijinal vs Smoothed');
xlabel('Zaman (s)'); ylabel('Genlik (g)');
legend('Orijinal', 'Smoothed');
grid on;
saveas(fig1, fullfile('..', 'assets', 'motor_time_domain.png'));

% frekans domeni karsilastirmasi
T_sec = 1; % 1 saniyelik analiz
N = Fs * T_sec;
x_seg = x(1:N);
y_seg = y(1:N);

X = fft(x_seg) / N;
Y = fft(y_seg) / N;

K = floor(N/2) + 1;
f = (0:K-1) * (Fs/N);

magX = abs(X(1:K));
magY = abs(Y(1:K));

magX(2:end-1) = 2 * magX(2:end-1);
magY(2:end-1) = 2 * magY(2:end-1);

fig2 = figure;
plot(f, magX); hold on;
plot(f, magY);
title('Motor Titresimi Spektrumu');
xlabel('Frekans (Hz)'); ylabel('Genlik');
legend('Orijinal', 'Smoothed');
xlim([0 5000]); % onemli titresim frekanslari
grid on;
saveas(fig2, fullfile('..', 'assets', 'motor_spectrum.png'));

% yorum: smoothing islemi gurultu tabanini asagi cekerken, yuksek frekansli 
% darbe bilesenlerini de zayiflatabilir.
