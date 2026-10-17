% 06 - STFT / Spektrogram Analizi

% STFT parametreleri
pencere_uzunlugu_stft = round(Fs * 0.05);
pencere_stft = hamming(pencere_uzunlugu_stft);
ortusme_stft = round(pencere_uzunlugu_stft * 0.75);
nfft_stft = max(256, 2^nextpow2(pencere_uzunlugu_stft));

% spektrogram cizimi
figure;
spectrogram(siren_filtrelenmis, pencere_stft, ortusme_stft, nfft_stft, Fs, 'yaxis');
title('Filtrelenmiş Sinyalin STFT Spektrogramı');
ylim([0 3]);
colormap('jet');

% grafigi kaydet
saveas(gcf, 'grafik/adim06_spektrogram.png');
disp('Adım 6 spektrogram grafiği kaydedildi.');
