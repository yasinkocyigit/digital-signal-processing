% 05 - Filtre Öncesi ve Sonrası Karşılaştırma

% FFT Hesaplaması -- filtrelenen
Y_fft_filt = fft(siren_filtrelenmis);
P2_filt = abs(Y_fft_filt/N);
P1_filt = P2_filt(1:floor(N/2));
P1_filt(2:end-1) = 2*P1_filt(2:end-1);

% zaman alani için karsilastirma
figure;
subplot(2,1,1);
plot(t_islenmis, siren_islenmis, 'b');
title('Filtre Öncesi Ham Sinyal (Zaman Alanı)');
xlabel('Zaman (s)'); ylabel('Genlik'); grid on;

subplot(2,1,2);
plot(t_islenmis, siren_filtrelenmis, 'r');
title('FIR Band-pass Filtre Sonrası Sinyal (Zaman Alanı)');
xlabel('Zaman (s)'); ylabel('Genlik'); grid on;

% grafigi kaydet
saveas(gcf, 'grafik/adim05_zaman_karsilastirma.png');

% frekans alani karsilastirmasi
figure;
subplot(2,1,1);
plot(f, P1, 'b');
title('Filtre Öncesi Spektrum (FFT)');
xlabel('Frekans (Hz)'); ylabel('Genlik');
xlim([0 3000]); grid on;

subplot(2,1,2);
plot(f, P1_filt, 'r');
title('FIR Band-pass Filtre Sonrası Spektrum (FFT)');
xlabel('Frekans (Hz)'); ylabel('Genlik');
xlim([0 3000]); grid on;

% grafigi kaydet
saveas(gcf, 'grafik/adim05_fft_karsilastirma.png');
disp('Adım 5 karşılaştırma grafikleri kaydedildi.');

% sonucu dinleme
disp('Filtrelenen ses çalınıyor...');
sound(siren_filtrelenmis, Fs);