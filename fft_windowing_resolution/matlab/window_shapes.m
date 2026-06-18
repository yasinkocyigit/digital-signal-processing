clc; clear; close all

% Parametreler
N = 256; % Pencere uzunlugu

% Pencere tanimlari
w_rect = ones(N,1);       % Rectangular pencere
w_hann = hann(N);         % Hann pencere
w_hamm = hamming(N);      % Hamming pencere

% Pencere sekilleri
figure;
subplot(3,1,1)
plot(w_rect, 'LineWidth', 1.2); grid on
title('Rectangular Pencere')
xlabel('n'); ylabel('Genlik')
ylim([-0.1 1.1]);

subplot(3,1,2)
plot(w_hann, 'LineWidth', 1.2); grid on
title('Hann Pencere')
xlabel('n'); ylabel('Genlik')
ylim([-0.1 1.1]);

subplot(3,1,3)
plot(w_hamm, 'LineWidth', 1.2); grid on
title('Hamming Pencere')
xlabel('n'); ylabel('Genlik')
ylim([-0.1 1.1]);

sgtitle('Farklı Pencere Fonksiyonlarının Şekilleri')
saveas(gcf, '../assets/window_shapes_comparison.png');
