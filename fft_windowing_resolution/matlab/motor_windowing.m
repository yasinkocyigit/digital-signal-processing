clc; clear; close all
%% motor verisini yukle
data_path = '../../data/B007_1_123.mat';
S = load(data_path);
x = S.X123_DE_time; % kanal sectik
Fs = 48000;

%% kisa bir segment sec
t_start = 0.5;  % saniye
dur_sec = 0.2;  % 200 ms segment
n1 = round(t_start*Fs) + 1;
n2 = min(length(x), n1 + round(dur_sec*Fs) - 1);
seg = x(n1:n2);
N = length(seg);

%% dc'yi kaldirmak
seg = seg - mean(seg);

%% pencereler
w_rect = ones(N,1);
w_hann = hann(N);
w_hamm = hamming(N);

seg_rect = seg .* w_rect;
seg_hann = seg .* w_hann;
seg_hamm = seg .* w_hamm;

%% fft
X_rect = fft(seg_rect)/N;
X_hann = fft(seg_hann)/N;
X_hamm = fft(seg_hamm)/N;
K = floor(N/2)+1;
f = (0:K-1)*(Fs/N);
mag_rect = abs(X_rect(1:K));
mag_hann = abs(X_hann(1:K));
mag_hamm = abs(X_hamm(1:K));
mag_rect(2:end-1) = 2*mag_rect(2:end-1);
mag_hann(2:end-1) = 2*mag_hann(2:end-1);
mag_hamm(2:end-1) = 2*mag_hamm(2:end-1);

%% spektrum karsilastirmasi (yakin bakis)
fmin = 0;
fmax = 1000;
figure;
plot(f, mag_rect, 'LineWidth', 1.0); hold on
plot(f, mag_hann, 'LineWidth', 1.0);
plot(f, mag_hamm, 'LineWidth', 1.0);
grid on
xlim([fmin fmax])
xlabel('Frequency (Hz)')
ylabel('|FFT|')
legend('Rectangular', 'Hann', 'Hamming')
title('Motor verisinde pencere seciminin spektruma etkisi (Yakin Bakis)')
saveas(gcf, '../assets/motor_windowing.png');
