% 01 - Veri Yükleme ve Ön İşleme
clear; clc; close all;

% Grafik klasorunu kontrol et, yoksa olustur
if ~exist('grafik', 'dir')
    mkdir('grafik');
end

% veriyi ice aktarma
dosya_yolu = '../data/40722-8-0-3.wav';
[siren_y, Fs] = audioread(dosya_yolu);
t = (0:length(siren_y)-1) / Fs; % Zaman vektörü

% kanal kontrolu
if size(siren_y, 2) > 1
    siren_y = mean(siren_y, 2);
    disp('Stereo ses mono formata dönüştürüldü.');
end

% 3. DC Offset - Normalization
siren_y_dc_kaldirilmis = siren_y - mean(siren_y);
normalizasyon_degeri = max(abs(siren_y_dc_kaldirilmis));
if normalizasyon_degeri == 0
    error('Sinyal normalizasyonu başarısız: DC bileşeni çıkarıldıktan sonra sinyal boş kaldı.');
end
siren_y_normalize = siren_y_dc_kaldirilmis / normalizasyon_degeri;

siren_islenmis = siren_y_normalize;
t_islenmis = t;

%
figure;
subplot(2,1,1);
plot(t, siren_y);
title('Ham Siren Sinyali');
xlabel('Zaman (s)'); ylabel('Genlik'); grid on;

subplot(2,1,2);
plot(t_islenmis, siren_islenmis);
title('Ön İşlemden Geçmiş Sinyal (DC Offset Giderilmiş ve Normalize Edilmiş)');
xlabel('Zaman (s)'); ylabel('Genlik'); grid on;

% grafigi kaydet
saveas(gcf, 'grafik/adim01zaman_alani.png');
disp('Grafik kaydedildi.');