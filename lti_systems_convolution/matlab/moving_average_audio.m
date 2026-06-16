% moving average filtresi: ses verisi analizi
% bu script, moving average (ma) filtresinin ses sinyali uzerindeki 
% zaman ve frekans domenindeki etkilerini inceler.

clc; clear; close all;

% ses verisinin yuklenmesi
% dosya yolu projenin veri klasorune gore ayarlanmistir.
file_path = fullfile('..', '..', 'data', 'euphoric.wav');
if ~exist(file_path, 'file')
    error('Ses dosyasi bulunamadi: %s', file_path);
end

[x, Fs] = audioread(file_path);
x = x(:,1); % mono kanal secimi

% moving average filtresi uygulama
M = 21; % pencere uzunlugu (m buyudukce filtreleme artar)
h = ones(1, M) / M;
y = filter(h, 1, x);

% zaman domeni analizi (yakinlastirma)
t = (0:length(x)-1) / Fs;
idx = (t >= 0.50) & (t <= 0.55); % 0.5 saniye civari kisa bir kesit

fig1 = figure;
plot(t(idx), x(idx)); hold on;
plot(t(idx), y(idx), 'LineWidth', 1.5);
title(['Zaman Domeni: Orijinal vs MA (M=' num2str(M) ')']);
xlabel('Zaman (s)'); ylabel('Genlik');
legend('Orijinal', 'Filtrelenmis');
grid on;
saveas(fig1, fullfile('..', 'assets', 'audio_time_domain.png'));

% frekans domeni (spektrum) analizi
% 1 saniyelik parca uzerinden fft
N = Fs * 1; 
x_seg = x(1:N);
y_seg = y(1:N);

X = fft(x_seg) / N;
Y = fft(y_seg) / N;

K = floor(N/2) + 1;
f = (0:K-1) * (Fs / N);

magX = abs(X(1:K));
magY = abs(Y(1:K));

% tek tarafli spektrum genlik duzeltmesi
magX(2:end-1) = 2 * magX(2:end-1);
magY(2:end-1) = 2 * magY(2:end-1);

fig2 = figure;
plot(f, magX); hold on;
plot(f, magY);
title('Spektrum Analizi: x vs y');
xlabel('Frekans (Hz)'); ylabel('Genlik');
legend('Orijinal Spektrum', 'Filtrelenmis Spektrum');
xlim([0 4000]); % onemli frekans bolgesi
grid on;
saveas(fig2, fullfile('..', 'assets', 'audio_spectrum.png'));

% yorum: ma filtresinin yuksek frekanslari nasil bastirdigi grafikte gorulebilir.
