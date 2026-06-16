clc; clear; close all
%% parametreler
Fs = 1000;
T = 1.0;
t = (0:1/Fs:T-1/Fs)';
N = length(t);
f0 = 50.5;      % bin'e tam oturmayan ton
x = sin(2*pi*f0*t);

%% pencereler
w_rect = ones(N,1);
w_hann = hann(N);
w_hamm = hamming(N);

%% pencere uygulanmis sinyaller
x_rect = x .* w_rect;
x_hann = x .* w_hann;
x_hamm = x .* w_hamm;

%% fft'ler
X_rect = fft(x_rect)/N;
X_hann = fft(x_hann)/N;
X_hamm = fft(x_hamm)/N;
K = floor(N/2)+1;
f = (0:K-1)*(Fs/N);
mag_rect = abs(X_rect(1:K));
mag_hann = abs(X_hann(1:K));
mag_hamm = abs(X_hamm(1:K));
mag_rect(2:end-1) = 2*mag_rect(2:end-1);
mag_hann(2:end-1) = 2*mag_hann(2:end-1);
mag_hamm(2:end-1) = 2*mag_hamm(2:end-1);

%% spektrum karsilastirmasi
figure;
plot(f, mag_rect, 'LineWidth', 1.2); hold on
plot(f, mag_hann, 'LineWidth', 1.2);
plot(f, mag_hamm, 'LineWidth', 1.2);
grid on
xlim([40 60])
xlabel('Frequency (Hz)')
ylabel('|FFT|')
legend('Rectangular', 'Hann', 'Hamming')
title('Ayni tek ton icin pencere etkisi')
saveas(gcf, '../assets/windowing_comparison.png');
