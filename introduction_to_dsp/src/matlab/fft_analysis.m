% FFT Analysis and Frequency Resolution Demonstration
% this script demonstrates the effect of record length (N) and zero-padding.

fs = 1000; % sampling frequency (Hz)
t = 0:1/fs:1-1/fs; % 1 second time vector

% create a signal with two closely spaced frequencies
f1 = 100; % 100 Hz
f2 = 105; % 105 Hz
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);

% short record (N=256)
N1 = 256;
x_short = x(1:N1);
X_short = fft(x_short);
f_short = (0:N1-1)*(fs/N1);

% long record (N=2048)
N2 = 2048;
t_long = 0:1/fs:2.048-1/fs;
x_long_sig = sin(2*pi*f1*t_long) + sin(2*pi*f2*t_long);
x_long = x_long_sig(1:N2);
X_long = fft(x_long);
f_long = (0:N2-1)*(fs/N2);

% short record with Zero-Padding to N=2048
X_padded = fft(x_short, N2);
f_padded = (0:N2-1)*(fs/N2);

% plotting
figure;
subplot(3,1,1);
plot(f_short, abs(X_short));
title('Short Record (N=256) - Poor Resolution');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([80 125]);

subplot(3,1,2);
plot(f_long, abs(X_long));
title('Long Record (N=2048) - Good Resolution');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([80 125]);

subplot(3,1,3);
plot(f_padded, abs(X_padded));
title('Short Record with Zero-Padding (N=256 padded to 2048) - Interpolated but not resolved');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([80 125]);

% save figure to assets folder
% mkdir('../assets') if it doesn't exist
if ~exist('../assets', 'dir')
    mkdir('../assets');
end
saveas(gcf, '../assets/fft_analysis.png');
