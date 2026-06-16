clc; clear; close all
%% parametreler
Fs = 2000;      % ornekleme frekansi
t = (0:1/Fs:1-1/Fs)';
% 50 Hz (dusuk) + 350 Hz (yuksek) + gurultu
x = sin(2*pi*50*t) + 0.5*sin(2*pi*350*t) + 0.15*randn(size(t));

%% fir filtre: moving average
b_fir = ones(1,9)/9;
a_fir = 1;
y_fir = filter(b_fir, a_fir, x);

%% iir filtre: 1. dereceden low-pass
% y[n] = (1-alpha)x[n] + alpha*y[n-1]
alpha = 0.85;
b_iir = 1 - alpha;
a_iir = [1 -alpha];
y_iir = filter(b_iir, a_iir, x);

%% durtu yanitlari
Nimp = 60;
imp = [1; zeros(Nimp-1,1)];
h_fir = filter(b_fir, a_fir, imp);
h_iir = filter(b_iir, a_iir, imp);

%% frekans cevaplari
[Hfir, w] = freqz(b_fir, a_fir, 1024, Fs);
[Hiir, ~] = freqz(b_iir, a_iir, 1024, Fs);

%% spektrum hesaplari
N = length(x);
K = floor(N/2)+1;
f = (0:K-1)*(Fs/N);
X    = fft(x)/N;
Yfir = fft(y_fir)/N;
Yiir = fft(y_iir)/N;
magX = abs(X(1:K));
magF = abs(Yfir(1:K));
magI = abs(Yiir(1:K));
magX(2:end-1) = 2*magX(2:end-1);
magF(2:end-1) = 2*magF(2:end-1);
magI(2:end-1) = 2*magI(2:end-1);

%% grafikler
figure;
subplot(4,1,1)
plot(t(1:300), x(1:300), 'k'); hold on
plot(t(1:300), y_fir(1:300), 'b', 'LineWidth', 1.1)
plot(t(1:300), y_iir(1:300), 'r', 'LineWidth', 1.1)
grid on; xlabel('Time (s)'); ylabel('Amplitude')
title('FIR ve IIR Filtre Uygulamasi')
legend('Original','FIR','IIR')

subplot(4,1,2)
stem(0:Nimp-1, h_fir, 'b', 'filled'); hold on
stem(0:Nimp-1, h_iir, 'r', 'filled')
grid on; xlabel('n'); ylabel('h[n]')
title('Durtu Yanitlari: FIR sonlu, IIR uzayan')
legend('FIR h[n]','IIR h[n]')

subplot(4,1,3)
plot(w, abs(Hfir), 'b', 'LineWidth', 1.2); hold on
plot(w, abs(Hiir), 'r', 'LineWidth', 1.2)
grid on; xlabel('Frequency (Hz)'); ylabel('Magnitude')
title('Frekans Cevabi Karsilastirmasi')
legend('FIR','IIR')

subplot(4,1,4)
plot(f, magX, 'k'); hold on
plot(f, magF, 'b', 'LineWidth', 1.1)
plot(f, magI, 'r', 'LineWidth', 1.1)
grid on; xlim([0 600]); xlabel('Frequency (Hz)'); ylabel('Magnitude')
title('Giris ve Cikis Spektrumlari')
legend('Original','FIR','IIR')

saveas(gcf, '../assets/fir_vs_iir_comparison.png');
