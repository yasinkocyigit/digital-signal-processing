% Windowing and Spectral Leakage Demonstration
% compares rectangular, hann, and hamming windows

fs = 1000;
N = 256;
n = 0:N-1;

% signal frequency not exactly on a bin to show maximum leakage
f0 = 100.5; 
x = sin(2*pi*(f0/fs)*n);

% define windows
w_rect = rectwin(N)';
w_hann = hann(N)';
w_hamm = hamming(N)';

% apply windows
x_rect = x .* w_rect;
x_hann = x .* w_hann;
x_hamm = x .* w_hamm;

% calculate FFT (with zero padding for smoother visualization)
N_fft = 2048;
X_rect = fft(x_rect, N_fft);
X_hann = fft(x_hann, N_fft);
X_hamm = fft(x_hamm, N_fft);

f = (0:N_fft-1)*(fs/N_fft);

% plot magnitude spectra in dB
figure;
plot(f, 20*log10(abs(X_rect)/max(abs(X_rect))), 'LineWidth', 1.5); hold on;
plot(f, 20*log10(abs(X_hann)/max(abs(X_hann))), 'LineWidth', 1.5);
plot(f, 20*log10(abs(X_hamm)/max(abs(X_hamm))), 'LineWidth', 1.5);
title('Windowing Effects: Leakage vs Main Lobe Width');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Rectangular', 'Hann', 'Hamming');
xlim([80 120]);
ylim([-80 0]);
grid on;

% save figure to assets folder
if ~exist('../assets', 'dir')
    mkdir('../assets');
end
saveas(gcf, '../assets/windowing_effects.png');
