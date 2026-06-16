clc; clear; close all
%% ses dosyasini oku
[x, Fs] = audioread('../../data/euphoric.wav');
if size(x,2) > 1
    x = mean(x, 2); % mono yap
end
dur = min(length(x), 3*Fs); % ilk 3 saniye
x = x(1:dur);
t = (0:length(x)-1)'/Fs;

%% filtreler
% low-pass: 1500 Hz alti kalsin
[b_lp, a_lp] = butter(4, 1500/(Fs/2), 'low');
% high-pass: 300 Hz alti bastirilsin
[b_hp, a_hp] = butter(4, 300/(Fs/2), 'high');

y_lp = filter(b_lp, a_lp, x);
y_hp = filter(b_hp, a_hp, x);

%% frekans cevapları
[Hlp, fH] = freqz(b_lp, a_lp, 2048, Fs);
[Hhp, ~ ] = freqz(b_hp, a_hp, 2048, Fs);

%% spektrumlar
N = length(x);
K = floor(N/2)+1;
f = (0:K-1)*(Fs/N);
X   = fft(x)/N;
Ylp = fft(y_lp)/N;
Yhp = fft(y_hp)/N;
magX = abs(X(1:K)); magX(2:end-1) = 2*magX(2:end-1);
magLP = abs(Ylp(1:K)); magLP(2:end-1) = 2*magLP(2:end-1);
magHP = abs(Yhp(1:K)); magHP(2:end-1) = 2*magHP(2:end-1);

%% grafikler
figure;
subplot(3,1,1)
plot(fH, abs(Hlp), 'b', 'LineWidth', 1.2); hold on
plot(fH, abs(Hhp), 'r', 'LineWidth', 1.2)
grid on; xlabel('Frequency (Hz)'); ylabel('|H(f)|')
title('Ses Filtreleri Frekans Cevaplari')
legend('Low-pass','High-pass')

subplot(3,1,2)
idx = 1:min(length(x), round(0.5*Fs)); % ilk 0.5 s
plot(t(idx), x(idx), 'k'); hold on
plot(t(idx), y_lp(idx), 'b'); plot(t(idx), y_hp(idx), 'r')
grid on; xlabel('Time (s)'); ylabel('Amplitude')
title('Zaman Alaninda Ses Sinyali')

subplot(3,1,3)
plot(f, magX, 'k'); hold on
plot(f, magLP, 'b'); plot(f, magHP, 'r')
grid on; xlim([0 5000]); xlabel('Frequency (Hz)'); ylabel('Magnitude')
title('Spektrumda Filtre Etkisi')
legend('Original','Low-pass','High-pass')

saveas(gcf, '../assets/audio_filtering_results.png');
