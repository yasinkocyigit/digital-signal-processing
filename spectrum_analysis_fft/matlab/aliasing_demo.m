%% Aliasing (Ortusme) Gosterimi
% bu script, ornekleme hizi yetersiz oldugunda frekanslarin nasil katlandigini gosterir.

%% 1. Tek Ton (Sinus) Uzerinden Aliasing
Fs_yuksek = 48000;
Fs_dusuk = 8000;
T = 1; % saniye
t_yuksek = (0:1/Fs_yuksek:T-1/Fs_yuksek)';
f0 = 6000; % 6 kHz sinyal

x_yuksek = sin(2*pi*f0*t_yuksek);

% basit Downsample (8 kHz'e dusurme)
D = Fs_yuksek / Fs_dusuk;
x_dusuk = x_yuksek(1:D:end);

% fFT Hesaplamalari
N1 = numel(x_yuksek);
X1 = abs(fft(x_yuksek))/N1;
f1 = (0:floor(N1/2))*(Fs_yuksek/N1);

N2 = numel(x_dusuk);
X2 = abs(fft(x_dusuk))/N2;
f2 = (0:floor(N2/2))*(Fs_dusuk/N2);

% gorsellestirme
figure;
subplot(2,1,1);
plot(f1, X1(1:numel(f1))); grid on;
title(sprintf("Orijinal Spektrum (Fs=%d Hz, f0=%d Hz)", Fs_yuksek, f0));
xlabel("Frekans (Hz)"); ylabel("Genlik");
xlim([0 10000]);

subplot(2,1,2);
plot(f2, X2(1:numel(f2))); grid on;
title(sprintf("Aliasing Spektrumu (Fs=%d Hz, Gorunen=%d Hz)", Fs_dusuk, abs(Fs_dusuk-f0)));
xlabel("Frekans (Hz)"); ylabel("Genlik");
xlim([0 4000]);

%% 3. Grafikleri Kaydetme
if ~exist('../assets', 'dir'), mkdir('../assets'); end
saveas(gcf, '../assets/aliasing_demo.png');


%% 2. Ses Verisi Uzerinde Aliasing Etkisi
% [x, Fs_true] = audioread("euphoric.wav"); % Varsa acin
% x_alias = x(1:6:end); % 48k -> 8k downsample
% soundsc(x, Fs_true); pause(3);
% soundsc(x_alias, 8000); % Metalik/bozuk ses duyulabilir
