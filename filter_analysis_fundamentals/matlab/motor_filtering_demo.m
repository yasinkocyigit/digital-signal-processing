clc; clear; close all
%% cwru verisini yukle
S = load('../../data/B007_1_123.mat');
x = S.X123_DE_time;
Fs = 48000;
x = x(:);
x = x - mean(x); % dc temizligi

%% 1 saniyelik segment
N = Fs * 1;
xseg = x(1:N);

%% spektrum
X = fft(xseg) / N;
K = floor(N/2) + 1;
f = (0:K-1) * (Fs/N);
magX = abs(X(1:K)); magX(2:end-1) = 2 * magX(2:end-1);

%% en buyuk peak tespiti
[peakVal, idxPeak] = max(magX);
peakFreq = f(idxPeak);

%% peak etrafinda band-pass
bw_bp = 200;
f1 = max(1, peakFreq - bw_bp);
f2 = min(Fs/2 - 1, peakFreq + bw_bp);
[b_bp, a_bp] = butter(4, [f1 f2]/(Fs/2), 'bandpass');
y_bp = filter(b_bp, a_bp, xseg);

%% notch filtresi katsayilari
r = 0.98;
w0 = 2*pi*peakFreq/Fs;
b_nt = [1, -2*cos(w0), 1];
a_nt = [1, -2*r*cos(w0), r^2];
y_nt = filter(b_nt, a_nt, y_bp);

%% spektrumlar
Ybp = fft(y_bp)/N; magBP = abs(Ybp(1:K)); magBP(2:end-1) = 2*magBP(2:end-1);
Ynt = fft(y_nt)/N; magNT = abs(Ynt(1:K)); magNT(2:end-1) = 2*magNT(2:end-1);

%% grafikler
figure;
subplot(3,1,1)
plot(f, magX, 'k'); grid on; xlim([0 5000])
title(sprintf('Orijinal Spektrum - Peak: %.1f Hz', peakFreq))

subplot(3,1,2)
plot(f, magBP, 'b'); grid on; xlim([max(0,f1-300) min(5000,f2+300)])
title('Band-pass Sonrasi Spektrum')

subplot(3,1,3)
plot(f, magBP, 'b'); hold on; plot(f, magNT, 'r')
grid on; xlim([max(0,f1-300) min(5000,f2+300)])
title('Notch Filtresi Etkisi')
legend('After BP','After Notch')

saveas(gcf, '../assets/motor_filtering_results.png');
