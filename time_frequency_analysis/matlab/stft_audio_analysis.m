% stft_audio_analysis.m
% bir ses sinyalini spektrogram kullanarak analiz eder.
clc; clear; close all

% ses dosyasini oku
wavfile = '../../data/euphoric.wav'; % ses dosyanizin yolunu belirtin
[x, fs_ses] = audioread(wavfile);
% stereo ise mono yap
if size(x,2) > 1
    x = mean(x, 2);
end
% dc ofsetini kaldir
x = x - mean(x);

% ilk 5 saniyeyi al
sure = 5;
n_ses = min(length(x), sure*fs_ses);
x = x(1:n_ses);
t_ses = (0:n_ses-1)/fs_ses;
fprintf("ses verisi: fs=%d hz | n=%d | sure=%.2f s\n", fs_ses, n_ses, n_ses/fs_ses);

% stft / spektrogram parametreleri
winLength_stft_ses = round(0.05 * fs_ses); % yaklasik 50 ms pencere
win_stft_ses = hann(winLength_stft_ses);
overlap_stft_ses = round(0.50 * winLength_stft_ses);
nfft_stft_ses = 2^nextpow2(winLength_stft_ses);

% spektrogram cizimi
figure('color', [1 1 1]);
spectrogram(x, win_stft_ses, overlap_stft_ses, nfft_stft_ses, fs_ses, 'yaxis');
title('konusma sinyali spektrogrami');
colorbar;
xlabel('zaman (s)');
ylabel('frekans (khz)');

% grafigi assets klasorune kaydet
saveas(gcf, '../assets/stft_speech_spectrogram.png');
