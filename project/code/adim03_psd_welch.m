% 03 - PSD / Welch Analizi

% parametreler
pencere_uzunlugu = round(Fs * 0.05);
pencere = hamming(pencere_uzunlugu);
ortusme = round(pencere_uzunlugu * 0.5);
nfft = max(256, 2^nextpow2(pencere_uzunlugu));

% pwelch ile PSD
figure;
pwelch(siren_islenmis, pencere, ortusme, nfft, Fs);
title('Welch Yöntemi ile Güç Spektral Yoğunluğu (PSD)');

% grafigi kaydet
saveas(gcf, 'grafik/adim03_psd_welch.png');
disp('Adım 3 PSD grafiği kaydedildi.');