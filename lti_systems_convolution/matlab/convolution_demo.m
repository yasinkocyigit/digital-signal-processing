% konvolusyon islemi ve fir filtreleme sezgisi
% bu script, konvolusyonun "katla-kaydir-carp-topla" mantigini 
% ve basit diziler uzerindeki etkisini gosterir.

clc; clear; close all;

% sayisal ornek
% sinyal x ve sistem h (moving average gibi davranan bir h)
x = [1, 2, 3];
h = [1, 1];

% konvolusyon sonucu uzunlugu: l_x + l_h - 1 = 3 + 2 - 1 = 4
y = conv(x, h);

fprintf('Giris x: [%s]\n', num2str(x));
fprintf('Sistem h: [%s]\n', num2str(h));
fprintf('Cikti y (conv): [%s]\n', num2str(y));

% fir filtreleme ve yumusatma (smoothing)
% katsayilar sinyal uzerinde gezen bir "kalip" (kernel) gibidir.
x_long = [0 0 1 2 3 2 1 0 0];
h_smooth = [0.2 0.6 0.2]; % 3-tap smoothing kernel

y_smooth = conv(x_long, h_smooth, 'same');

fig = figure;
subplot(2,1,1);
stem(x_long, 'filled');
title('Orijinal Sinyal (x)');
grid on;

subplot(2,1,2);
stem(y_smooth, 'filled');
title('Filtrelenmis Sinyal (y) - Yumusatma Etkisi');
grid on;

% grafiklerde tepenin yayildigi ve genligin hafif azaldigi gozlenebilir.
% grafigi assets klasorune kaydet
saveas(fig, fullfile('..', 'assets', 'convolution_demo.png'));
