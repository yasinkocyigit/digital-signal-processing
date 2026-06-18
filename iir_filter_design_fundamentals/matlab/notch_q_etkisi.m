% notch_q_etkisi.m
% farkli kalite faktoru (q) degerlerinin notch filtrenin
% bant genisligine ve seciciligine etkisini gosterir.

% temizlik
clc; clear; close all;

% temel parametreler
fs = 1000;              % ornekleme frekansi
f0 = 50;                % bastirilacak merkez frekans (hz)
q_degerleri = [5, 15, 50];  % incelenecek q degerleri

% gorsellestirme icin pencere olustur
figure;

% her bir q degeri icin dongu
for i = 1:length(q_degerleri)
    q = q_degerleri(i);
    
    % normalize frekans ve bant genisligi hesabi
    w0 = f0 / (fs/2);
    bw = w0 / q;
    
    % iir notch tasarimi
    [b, a] = iirnotch(w0, bw);
    
    % frekans cevabi hesabi
    [h, f] = freqz(b, a, 2048, fs);
    
    % grafik cizimi
    subplot(3, 1, i);
    plot(f, abs(h), 'LineWidth', 1.2);
    grid on;
    xlabel('frekans (hz)');
    ylabel('|h(f)|');
    title(['q = ', num2str(q)]);
    xlim([0 200]);
end

% grafigin assets klasorune kaydedilmesi
saveas(gcf, '../assets/notch_q_etkisi.png');
