clc; clear; close all
%% sinyal parametreleri
Fs = 1000;      % ornekleme frekansi (Hz)
f1 = 50;        % 1. frekans
f2 = 52;        % 2. frekans (yakin frekans)
A1 = 1.0;
A2 = 1.0;

%% kisa kayit
T_short = 0.5;  % 0.5 saniye
t_short = (0:1/Fs:T_short-1/Fs)';
x_short = A1*sin(2*pi*f1*t_short) + A2*sin(2*pi*f2*t_short);

N_short = length(x_short);
X_short = fft(x_short)/N_short;
K_short = floor(N_short/2) + 1;
f_short = (0:K_short-1)*(Fs/N_short);
mag_short = abs(X_short(1:K_short));
mag_short(2:end-1) = 2*mag_short(2:end-1); % tek tarafli 2x kurali

%% uzun kayit
T_long = 4.0;   % 4 saniye
t_long = (0:1/Fs:T_long-1/Fs)';
x_long = A1*sin(2*pi*f1*t_long) + A2*sin(2*pi*f2*t_long);

N_long = length(x_long);
X_long = fft(x_long)/N_long;
K_long = floor(N_long/2) + 1;
f_long = (0:K_long-1)*(Fs/N_long);
mag_long = abs(X_long(1:K_long));
mag_long(2:end-1) = 2*mag_long(2:end-1); % tek tarafli 2x kurali

%% delta-f degerlerini yazdir
fprintf("Kisa kayit: T = %.2f s, N = %d, Delta f = %.2f Hz\n", T_short, N_short, Fs/N_short);
fprintf("Uzun kayit: T = %.2f s, N = %d, Delta f = %.2f Hz\n", T_long, N_long, Fs/N_long);

%% fft karsilastirmasi
figure;
subplot(1,2,1)
plot(f_short, mag_short, 'LineWidth', 1.2); grid on
xlim([40 60])
xlabel("Frequency (Hz)")
ylabel("|FFT|")
title(sprintf("Kisa kayit FFT (Delta f = %.2f Hz)", Fs/N_short))

subplot(1,2,2)
plot(f_long, mag_long, 'LineWidth', 1.2); grid on
xlim([40 60])
xlabel("Frequency (Hz)")
ylabel("|FFT|")
title(sprintf("Uzun kayit FFT (Delta f = %.2f Hz)", Fs/N_long))

sgtitle("Ayni iki frekansli sinyal: kisa vs uzun kayit")
saveas(gcf, '../assets/resolution_demo.png');
