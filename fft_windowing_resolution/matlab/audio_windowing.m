clc; clear; close all
%% ses dosyasini oku
audio_path = '../../data/euphoric.wav';
[x, Fs] = audioread(audio_path);

% stereo ise mono yap
if size(x,2) > 1
    x = mean(x, 2);
end

%% kisa bir parca sec
t_start = 1.0;  % saniye
dur_sec = 0.05; % 50 ms
n1 = round(t_start*Fs) + 1;
n2 = min(length(x), n1 + round(dur_sec*Fs) - 1);
seg = x(n1:n2);
N = length(seg);

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

%% spektrum karsilastirmasi
figure;
plot(f, mag_rect, 'LineWidth', 1.1); hold on
plot(f, mag_hann, 'LineWidth', 1.1);
plot(f, mag_hamm, 'LineWidth', 1.1);
grid on
xlim([0 4000]) 
xlabel('Frequency (Hz)')
ylabel('|FFT|')
legend('Rectangular', 'Hann', 'Hamming')
title('Gercek ses verisinde pencere seciminin etkisi')
saveas(gcf, '../assets/audio_windowing.png');
