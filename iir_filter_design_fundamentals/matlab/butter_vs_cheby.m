% butter_vs_cheby.m
% ayni mertebe ve kesim frekansina sahip butterworth ve chebyshev
% filtrelerinin karsilastirmasi.

% temizlik
clc; clear; close all;

% temel parametreler
fs = 2000;      % ornekleme frekansi (hz)
fc = 200;       % kesim frekansi (hz)
n = 4;          % filtre mertebesi
rp = 1;         % chebyshev tip i icin ripple degeri (db)

% normalize kesim frekansi
wn = fc / (fs/2);

% butterworth tasarimi
[b_butt, a_butt] = butter(n, wn, 'low');

% chebyshev tip i tasarimi
[b_cheb, a_cheb] = cheby1(n, rp, wn, 'low');

% frekans cevaplarinin hesaplanmasi
[h_butt, f] = freqz(b_butt, a_butt, 2048, fs);
[h_cheb, ~] = freqz(b_cheb, a_cheb, 2048, fs);

% gorsellestirme
figure;
plot(f, abs(h_butt), 'LineWidth', 1.4); hold on;
plot(f, abs(h_cheb), 'LineWidth', 1.4);
grid on;
xlabel('frekans (hz)');
ylabel('|h(f)|');
title('butterworth ve chebyshev tip i karsilastirmasi');
legend('butterworth', 'chebyshev tip i');
xlim([0 600]);

% grafigin assets klasorune kaydedilmesi
saveas(gcf, '../assets/butter_vs_cheby.png');
