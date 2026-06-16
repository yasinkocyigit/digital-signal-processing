clc; clear; close all
%% parametreler
Fs = 1000;
T = 1.0;
t = (0:1/Fs:T-1/Fs)';
N = length(t);
df = Fs/N;
fprintf("N = %d, Delta f = %.2f Hz\n", N, df);

%% iki sinyal
f_on = 50;      % bin'e oturan frekans (df=1 Hz ise tam oturur)
f_off = 50.5;   % bin'e oturmayan frekans
x_on = sin(2*pi*f_on*t);
x_off = sin(2*pi*f_off*t);

%% fft hesaplari
X_on = fft(x_on)/N;
X_off = fft(x_off)/N;
K = floor(N/2) + 1;
f = (0:K-1)*(Fs/N);
mag_on = abs(X_on(1:K));
mag_off = abs(X_off(1:K));
mag_on(2:end-1) = 2*mag_on(2:end-1);
mag_off(2:end-1) = 2*mag_off(2:end-1);

%% grafikler
figure;
subplot(2,1,1)
plot(f, mag_on, 'LineWidth', 1.2); grid on
xlim([40 60])
xlabel("Frequency (Hz)")
ylabel("|FFT|")
title("Bin'e tam oturan ton: 50 Hz")

subplot(2,1,2)
plot(f, mag_off, 'LineWidth', 1.2); grid on
xlim([40 60])
xlabel("Frequency (Hz)")
ylabel("|FFT|")
title("Bin'e oturmayan ton: 50.5 Hz")

sgtitle("Leakage gosterimi: tek tonlu sinyalde enerji yayilimi")
saveas(gcf, '../assets/leakage_demo.png');
