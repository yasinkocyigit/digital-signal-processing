% fft_time_comparison.m
% fft'nin duragan olmayan sinyallerde zaman bilgisini nasil kaybettigini gosterir.
clc; clear; close all

% ortak parametreler
fs = 1000; % ornekleme frekansi (hz)
t_suresi = 2; % sinyal suresi (s)
t = (0:1/fs:t_suresi-1/fs)'; % zaman ekseni
n = length(t); % ornek sayisi

% sinyal a: tum sure boyunca 100 hz
x1 = sin(2*pi*100*t);

% sinyal b: ilk yarida 50 hz, ikinci yarida 150 hz
x2 = zeros(size(t));
mid = n/2;
x2(1:mid)     = sin(2*pi*50*t(1:mid));
x2(mid+1:end) = sin(2*pi*150*t(mid+1:end));

% sinyal a icin tek tarafli fft
X1 = fft(x1)/n;
k_fft = floor(n/2) + 1;
f_fft = (0:k_fft-1)*(fs/n);
mag1 = abs(X1(1:k_fft));
mag1(2:end-1) = 2*mag1(2:end-1);

% sinyal b icin tek tarafli fft
X2 = fft(x2)/n;
mag2 = abs(X2(1:k_fft));
mag2(2:end-1) = 2*mag2(2:end-1);

% gorsellestirme
figure('color', [1 1 1]);
subplot(2,2,1)
plot(t, x1, 'linewidth', 1.1)
grid on
xlabel('zaman (s)')
ylabel('genlik')
title('sinyal a: 2 saniye boyunca 100 hz')
xlim([0 t_suresi])

subplot(2,2,2)
plot(f_fft, mag1, 'linewidth', 1.1)
grid on
xlabel('frekans (hz)')
ylabel('|X(f)|')
title('tek tarafli fft: 100 hz tepesi')
xlim([0 200])

subplot(2,2,3)
plot(t, x2, 'linewidth', 1.1)
grid on
xlabel('zaman (s)')
ylabel('genlik')
title('sinyal b: 0-1 s 50 hz, 1-2 s 150 hz')
xlim([0 t_suresi])

subplot(2,2,4)
plot(f_fft, mag2, 'linewidth', 1.1)
grid on
xlabel('frekans (hz)')
ylabel('|X(f)|')
title('tek tarafli fft: 50 hz ve 150 hz tepeleri')
xlim([0 200])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/fft_time_comparison.png');
