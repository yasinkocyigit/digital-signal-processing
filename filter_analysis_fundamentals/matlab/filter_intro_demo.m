clc; clear; close all
%% sinyal parametreleri
Fs = 2000;      % ornekleme frekansi (Hz)
t = (0:1/Fs:1-1/Fs)';
x = sin(2*pi*50*t) + 0.4*sin(2*pi*400*t); % 50 Hz ve 400 Hz bilesenleri

%% spektrum hesabi
N = length(x);
X = fft(x)/N;
K = floor(N/2)+1;
f = (0:K-1)*(Fs/N);
mag = abs(X(1:K));
mag(2:end-1) = 2*mag(2:end-1);

%% grafikleme
figure;
subplot(2,1,1)
plot(t(1:300), x(1:300)); grid on
xlabel('Time (s)'); ylabel('Amplitude')
title('Zaman Alaninda Ornek Sinyal')

subplot(2,1,2)
plot(f, mag, 'LineWidth', 1.2); grid on
xlim([0 600])
xlabel('Frequency (Hz)'); ylabel('|X(f)|')
title('Sinyalin Spektrumu: 50 Hz ve 400 Hz bilesenleri')

saveas(gcf, '../assets/filter_intro_spectrum.png');
