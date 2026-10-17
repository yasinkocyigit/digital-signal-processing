% 07 - Filtrenin Farklı Köpek Ses Kaydına Uygulanması ve FFT

% Gerekli değişkenler yoksa önceki adımları çalıştır
if ~exist('Fs', 'var') || ~exist('siren_islenmis', 'var')
    run('adim01_veri_ve_onisleme.m');
end
if ~exist('b_katsayilari', 'var')
    run('adim04_filtre_tasarimi.m');
end

yeni_dosya = '../data/31323-3-0-2.wav';
[kopek_y, Fs_kopek] = audioread(yeni_dosya);

% On isleme
if size(kopek_y, 2) > 1
    kopek_y = mean(kopek_y, 2);
end
kopek_y = kopek_y - mean(kopek_y);
normalizasyon_degeri = max(abs(kopek_y));
if normalizasyon_degeri == 0
    error('Köpek sesi normalizasyonu başarısız: DC bileşeni çıkarıldıktan sonra sinyal boş kaldı.');
end
kopek_islenmis = kopek_y / normalizasyon_degeri;

% Fs uyumsuzsa resample et
if Fs_kopek ~= Fs
    kopek_islenmis = resample(kopek_islenmis, Fs, Fs_kopek);
    disp(['Köpek sesi ' num2str(Fs_kopek) ' Hz''den ' num2str(Fs) ' Hz''e resample edildi.']);
    Fs_kopek = Fs;
end

t_kopek = (0:length(kopek_islenmis)-1) / Fs_kopek;

% ayni filtreyi uygula
kopek_filtrelenmis = filtfilt(b_katsayilari, 1, kopek_islenmis);

% zaman alani
figure;
subplot(2,1,1);
plot(t_kopek, kopek_islenmis, 'b');
title('Orijinal Köpek Ses Kaydı (Class 3)');
xlabel('Zaman (s)'); ylabel('Genlik'); grid on;

subplot(2,1,2);
plot(t_kopek, kopek_filtrelenmis, 'r');
title('Siren Filtresi Uygulanmış Sinyal (Zaman Alanı)');
xlabel('Zaman (s)'); ylabel('Genlik'); grid on;

saveas(gcf, 'grafik/adim07_kopek_sesi_zaman.png');

% FFT hesaplama
N_kopek = length(kopek_islenmis);
f_kopek = (0:N_kopek/2-1)*(Fs_kopek/N_kopek);

% orijinal ses FFT
Y_kopek = fft(kopek_islenmis);
P2_kopek = abs(Y_kopek/N_kopek);
P1_kopek = P2_kopek(1:floor(N_kopek/2));
P1_kopek(2:end-1) = 2*P1_kopek(2:end-1);

% filtreli ses FFT
Y_kopek_filt = fft(kopek_filtrelenmis);
P2_kopek_filt = abs(Y_kopek_filt/N_kopek);
P1_kopek_filt = P2_kopek_filt(1:floor(N_kopek/2));
P1_kopek_filt(2:end-1) = 2*P1_kopek_filt(2:end-1);

% frekans alani
figure;
subplot(2,1,1);
plot(f_kopek, P1_kopek, 'b');
title('Orijinal Köpek Ses Kaydı Spektrumu (FFT)');
xlabel('Frekans (Hz)'); ylabel('Genlik');
xlim([0 3000]); grid on;

subplot(2,1,2);
plot(f_kopek, P1_kopek_filt, 'r');
title('Siren Filtresi Uygulanmış Spektrum (FFT)');
xlabel('Frekans (Hz)'); ylabel('Genlik');
xlim([0 3000]); grid on;

saveas(gcf, 'grafik/adim07_kopek_sesi_fft.png');
disp('Adım 7 grafikleri kaydedildi.');