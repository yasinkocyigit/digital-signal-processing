% welch_real_data_audio.m
% gercek bir ses sinyalini welch psd kullanarak analiz eder.
clc; clear; close all

% ses dosyasini oku
wavfile = '../../data/euphoric.wav'; % ses dosyanizin yolunu belirtin
[x, fs_ses] = audioread(wavfile);
% stereo ise mono yap
if size(x,2) > 1
    x = mean(x, 2);
end
% dc ofsetini cikar
x = x - mean(x);

% ilk 5 saniyeyi al
sure = 5;
n_ses = min(length(x), sure*fs_ses);
x = x(1:n_ses);
t_ses = (0:n_ses-1)/fs_ses;
fprintf("ses verisi: fs=%d hz | n=%d | sure=%.2f s\n", fs_ses, n_ses, n_ses/fs_ses);

% ses icin welch psd parametreleri
winLength_ses = round(0.05 * fs_ses); % yaklasik 50 ms pencere
win_ses = hann(winLength_ses);
overlap_ses = round(0.50 * winLength_ses);
nfft_ses = 2^nextpow2(winLength_ses);

% ses icin welch psd hesabi
[pxx_ses, f_ses] = pwelch(x, win_ses, overlap_ses, nfft_ses, fs_ses);

% gorsellestirme
figure('color', [1 1 1]);
subplot(2,1,1)
plot(t_ses, x, 'linewidth', 1.0)
grid on
xlabel('zaman (s)')
ylabel('genlik')
title('ses sinyali - zaman alani')
xlim([0 min(5, t_ses(end))])

subplot(2,1,2)
plot(f_ses, 10*log10(pxx_ses), 'linewidth', 1.2)
grid on
xlabel('frekans (hz)')
ylabel('psd (db/hz)')
title('ses sinyali - welch psd')
xlim([0 5000])

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/welch_audio_psd.png');
