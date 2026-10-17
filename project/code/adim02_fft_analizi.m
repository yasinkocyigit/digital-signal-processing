% 02 - FFT Analizi
N = length(siren_islenmis);
f = (0:N/2-1)*(Fs/N);

% FFT hesapla
Y_fft = fft(siren_islenmis);
P2 = abs(Y_fft/N);
P1 = P2(1:floor(N/2));
P1(2:end-1) = 2*P1(2:end-1);

% tek tarafli fft spektrumu
figure;
plot(f, P1, 'b');
title('Siren Sinyalinin Tek Taraflı FFT Spektrumu');
xlabel('Frekans (Hz)'); ylabel('Genlik');
xlim([0 3000]); grid on;

% grafigi kaydet
saveas(gcf, 'grafik/adim02_fft_spektrum.png');
disp('Adım 2 FFT grafiği kaydedildi.');