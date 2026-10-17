% 04 - FIR Band-pass Filtre Tasarimi ve Uygulamasi

% filtre icin parametreler
F_alt = 500;
F_ust = 1600;
Filtre_Derecesi = 100;

% FIR Band-pass Filtre Tasarimi
Wn = [F_alt/(Fs/2), F_ust/(Fs/2)];
b_katsayilari = fir1(Filtre_Derecesi, Wn, 'bandpass');

% Filtre Frekans Cevabi
figure;
freqz(b_katsayilari, 1, 1024, Fs);
title('Tasarlanan FIR Band-pass Filtrenin Frekans Cevabı');

% grafigi kaydet
saveas(gcf, 'grafik/adim04_filtre_cevabi.png');
disp('Adım 4 filtre frekans cevabı grafiği kaydedildi.');

% filtreyi sinyale uygula
siren_filtrelenmis = filtfilt(b_katsayilari, 1, siren_islenmis);
