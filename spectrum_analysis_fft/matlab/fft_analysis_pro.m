%% Profesyonel FFT Analizi ve Spektrum Okuma
% bu script, dogru frekans ekseni kurulumunu ve genlik duzeltmesini gosterir.

%% 1. Sinyal Hazirligi
Fs = 48000;
T = 1; % saniye
t = (0:1/Fs:T-1/Fs)';
f0 = 1200; % 1.2 kHz sinus
x = 0.7 * sin(2*pi*f0*t); % 0.7 genlikli sinyal

%% 2. FFT ve Frekans Ekseni
N = numel(x);
X = fft(x);

% tek tarafli spektrum (0'dan Nyquist'e)
K = floor(N/2) + 1;
X_tek = X(1:K);
f = (0:K-1) * (Fs/N);

% genlik Normalizasyonu ve 2x Kurali
mag = abs(X_tek) / N;
mag(2:end-1) = 2 * mag(2:end-1); % dC ve Nyquist haric genligi iki katina cikar

%% 3. Peak (Tepe Noktasi) Bulma
[max_val, idx] = max(mag);
baskin_frekans = f(idx);

fprintf("Baskin Frekans: %.2f Hz\n", baskin_frekans);
fprintf("Olculen Genlik: %.2f (Beklenen: 0.70)\n", max_val);

%% 4. Gorsellestirme
figure;
plot(f, mag, 'LineWidth', 1.5); grid on;
xlabel("Frekans (Hz)"); ylabel("Genlik");
title(sprintf("Tek Tarafli Spektrum - Peak: %.1f Hz", baskin_frekans));
xlim([0 5000]); % 5 kHz'e kadar odaklan

%% 5. Grafikleri Kaydetme
if ~exist('../assets', 'dir'), mkdir('../assets'); end
saveas(gcf, '../assets/fft_spectrum.png');


% birden fazla tepeyi bulmak icin (Opsiyonel)
% [pks, locs] = findpeaks(mag, f, 'MinPeakHeight', 0.1);
