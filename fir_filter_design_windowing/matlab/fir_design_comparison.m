clc; clear; close all;

%% parametreler
fs = 2000;              % ornekleme frekansi (hz)
fc = 400;               % kesim frekansi (hz)
wn = fc / (fs/2);       % normalize edilmis kesim frekansi

%% mertebe etkisi analizi
% ayni pencere (hamming) kullanilarak farkli mertebeler test edilmektedir
n1 = 20;                % dusuk mertebe
n2 = 100;               % yuksek mertebe

h1 = fir1(n1, wn, 'low', hamming(n1+1));
h2 = fir1(n2, wn, 'low', hamming(n2+1));

[H1, f] = freqz(h1, 1, 1024, fs);
[H2, ~] = freqz(h2, 1, 1024, fs);

figure('Name', 'Mertebe Karsilastirmasi', 'NumberTitle', 'off');
subplot(2,1,1);
plot(f, abs(H1), 'LineWidth', 1.2); hold on;
plot(f, abs(H2), 'LineWidth', 1.2);
grid on; xlim([0 fs/2]);
title(['FIR Filtre Mertebe Karsilastirmasi (fc = ', num2str(fc), ' Hz)']);
xlabel('Frekans (Hz)'); ylabel('Genlik');
legend(['N = ', num2str(n1)], ['N = ', num2str(n2)]);

subplot(2,1,2);
plot(f, 20*log10(abs(H1)), 'LineWidth', 1.2); hold on;
plot(f, 20*log10(abs(H2)), 'LineWidth', 1.2);
grid on; xlim([0 fs/2]); ylim([-100 10]);
xlabel('Frekans (Hz)'); ylabel('Genlik (dB)');
saveas(gcf, '../assets/order_comparison.png');

%% pencere fonksiyonu etkisi analizi
% ayni mertebe (n=50) kullanilarak farkli pencere tipleri test edilmektedir
n = 50;
h_rect = fir1(n, wn, 'low', rectwin(n+1));
h_hamm = fir1(n, wn, 'low', hamming(n+1));
h_black = fir1(n, wn, 'low', blackman(n+1));

[H_rect, ~] = freqz(h_rect, 1, 1024, fs);
[H_hamm, ~] = freqz(h_hamm, 1, 1024, fs);
[H_black, ~] = freqz(h_black, 1, 1024, fs);

figure('Name', 'Pencere Karsilastirmasi', 'NumberTitle', 'off');
plot(f, 20*log10(abs(H_rect)), 'LineWidth', 1.2); hold on;
plot(f, 20*log10(abs(H_hamm)), 'LineWidth', 1.2);
plot(f, 20*log10(abs(H_black)), 'LineWidth', 1.2);
grid on; xlim([0 fs/2]); ylim([-120 10]);
title(['Farkli Pencere Fonksiyonlari (N = ', num2str(n), ')']);
xlabel('Frekans (Hz)'); ylabel('Genlik (dB)');
legend('Rectangular', 'Hamming', 'Blackman');
saveas(gcf, '../assets/window_comparison.png');

%% uygulama: gurultulu sinyal filtreleme
% tasarlanan filtrenin zaman alanindaki etkisi incelenmektedir
t = (0:1/fs:0.1)'; 
signal = sin(2*pi*100*t);                       % 100 hz temiz sinyal
noise = 0.5*sin(2*pi*800*t) + 0.2*randn(size(t)); % 800 hz gurultu ve beyaz gurultu
noisy_signal = signal + noise;

filtered_signal = filter(h2, 1, noisy_signal);

figure('Name', 'Sinyal Filtreleme Uygulamasi', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, noisy_signal); grid on;
title('Gurultulu Giris Sinyali'); xlabel('Zaman (s)'); ylabel('Genlik');
subplot(2,1,2);
plot(t, filtered_signal); grid on;
title('Filtrelenmis Cikis Sinyali (N=100, Hamming)'); xlabel('Zaman (s)'); ylabel('Genlik');
saveas(gcf, '../assets/filtering_application.png');

