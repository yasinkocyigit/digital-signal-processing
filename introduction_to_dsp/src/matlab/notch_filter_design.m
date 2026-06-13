% 50 Hz Notch Filter Design
% demonstrates IIR filter design for rejecting specific frequencies

fs = 1000; % sampling frequency
f0 = 50;   % target frequency to reject (Hz)
w0 = 2*pi*(f0/fs); % normalized angular frequency

r = 0.95; % radius of the poles (controls notch bandwidth)

% filter coefficients based on H(z) equation:
% H(z) = (1 - 2*cos(w0)*z^-1 + z^-2) / (1 - 2*r*cos(w0)*z^-1 + r^2*z^-2)
b = [1, -2*cos(w0), 1];
a = [1, -2*r*cos(w0), r^2];

% plot frequency response
figure;
freqz(b, a, 2048, fs);
title('Frequency Response of 50 Hz Notch Filter');
if ~exist('../assets', 'dir')
    mkdir('../assets');
end
saveas(gcf, '../assets/notch_filter_freqz.png');

% plot pole-zero map
figure;
zplane(b, a);
title('Pole-Zero Plot of 50 Hz Notch Filter');
saveas(gcf, '../assets/notch_filter_zplane.png');
