clc; clear; close all
%% sinyal parametreleri
Fs = 1000;      % ornekleme frekansi
T = 0.5;        % kisa kayit
t = (0:1/Fs:T-1/Fs)';
f1 = 50;
f2 = 52;
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);
N = length(x);

%% normal fft
X = fft(x)/N;
K = floor(N/2) + 1;
f = (0:K-1)*(Fs/N);
mag = abs(X(1:K));
mag(2:end-1) = 2*mag(2:end-1);

%% zero-padding ile daha buyuk fft
Npad = 4000;    % daha buyuk fft uzunlugu
Xpad = fft(x, Npad)/N; % dikkat: orijinal N ile normalize ediyoruz
Kpad = floor(Npad/2) + 1;
fpad = (0:Kpad-1)*(Fs/Npad);
magpad = abs(Xpad(1:Kpad));
magpad(2:end-1) = 2*magpad(2:end-1);

%% delta-f bilgileri
fprintf("Orijinal veri uzunlugu: N = %d, Delta f = %.2f Hz\n", N, Fs/N);
fprintf("Zero-padded FFT uzunlugu: Npad = %d, frekans adimi = %.2f Hz\n", Npad, Fs/Npad);

%% grafikler
figure;
subplot(1,2,1)
plot(f, mag, 'LineWidth', 1.2); grid on
xlim([45 57])
xlabel("Frequency (Hz)")
ylabel("|FFT|")
title(sprintf("Normal FFT (N = %d, \\Deltaf = %.2f Hz)", N, Fs/N))

subplot(1,2,2)
plot(fpad, magpad, 'LineWidth', 1.2); grid on
xlim([45 57])
xlabel("Frequency (Hz)")
ylabel("|FFT|")
title(sprintf("Zero-padded FFT (N_{pad} = %d, adim = %.2f Hz)", Npad, Fs/Npad))

sgtitle("Ayni veri: normal FFT ve zero-padding sonrasi FFT")
saveas(gcf, '../assets/zeropadding_demo.png');
