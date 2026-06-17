clc; clear; close all;

%% parametreler
fs = 1000;              % ornekleme frekansi (hz)
f0 = 50;                % bastirilacak sebeke gurultusu frekansi (hz)
w0 = 2*pi*f0/fs;        % normalize edilmis radyan frekans
r1 = 0.85;              % genis bantli notch icin kutup yaricapi
r2 = 0.98;              % dar bantli notch icin kutup yaricapi

%% iir notch filtre tasarimi
% katsayilarin hesaplanmasi (sifirlar birim cember uzerinde, kutuplar iceride)
b = [1 -2*cos(w0) 1];
a1 = [1 -2*r1*cos(w0) r1^2];
a2 = [1 -2*r2*cos(w0) r2^2];

%% frekans cevabi analizi
[h1, f] = freqz(b, a1, 1024, fs);
[h2, ~] = freqz(b, a2, 1024, fs);

figure('Name', 'Notch Filtre Analizi', 'NumberTitle', 'off');
subplot(2,1,1);
plot(f, abs(h1), 'LineWidth', 1.2); hold on;
plot(f, abs(h2), 'LineWidth', 1.2);
grid on; xlim([0 150]);
title(['IIR Notch Filtre Frekans Cevabi (f0 = ', num2str(f0), ' Hz)']);
xlabel('Frekans (Hz)'); ylabel('Genlik');
legend(['r = ', num2str(r1)], ['r = ', num2str(r2)]);

subplot(2,1,2);
plot(f, 20*log10(abs(h1)), 'LineWidth', 1.2); hold on;
plot(f, 20*log10(abs(h2)), 'LineWidth', 1.2);
grid on; xlim([0 150]); ylim([-60 5]);
xlabel('Frekans (Hz)'); ylabel('Genlik (dB)');
saveas(gcf, '../assets/notch_filter_analysis.png');

%% kutup-sifir diyagrami (kararlilik analizi)
figure('Name', 'Kutup-Sifir Analizi', 'NumberTitle', 'off');
zplane(b, a2);
title(['IIR Notch Filtre Z-Duzlemi Analizi (r = ', num2str(r2), ')']);
saveas(gcf, '../assets/zplane_analysis.png');

%% uygulama: sebeke gurultusu temizleme
t = (0:1/fs:0.5)';
clean_signal = sin(2*pi*10*t);                  % 10 hz ana sinyal
noise = 0.5*sin(2*pi*f0*t);                     % 50 hz sebeke gurultusu
noisy_signal = clean_signal + noise;

% filtrenin uygulanmasi
filtered_signal = filter(b, a2, noisy_signal);

figure('Name', 'Zaman Alani Uygulamasi', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, noisy_signal); grid on;
title('Gurultulu Giris Sinyali (10 Hz + 50 Hz)');
xlabel('Zaman (s)'); ylabel('Genlik');

subplot(2,1,2);
plot(t, filtered_signal); grid on;
title('Filtrelenmis Cikis Sinyali (r = 0.98)');
xlabel('Zaman (s)'); ylabel('Genlik');
saveas(gcf, '../assets/line_noise_removal.png');

%% iir vs fir karsilastirmasi
% ayni keskinlik icin gereken fir mertebesi tahmini
n_fir = 150;
h_fir = fir1(n_fir, [48 52]/(fs/2), 'stop');
[h_fir_freq, ~] = freqz(h_fir, 1, 1024, fs);

figure('Name', 'IIR vs FIR Karsilastirmasi', 'NumberTitle', 'off');
plot(f, 20*log10(abs(h2)), 'LineWidth', 1.5); hold on;
plot(f, 20*log10(abs(h_fir_freq)), '--', 'LineWidth', 1.2);
grid on; xlim([30 70]); ylim([-60 5]);
title('IIR (2. Mertebe) vs FIR (150. Mertebe) Karsilastirmasi');
xlabel('Frekans (Hz)'); ylabel('Genlik (dB)');
legend('IIR Notch', 'FIR Equiripple/Window');
saveas(gcf, '../assets/iir_vs_fir_comparison.png');
