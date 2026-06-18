% 2-Point Moving Average Filter (FIR) Analysis
% difference equation: y[n] = 0.5*x[n] + 0.5*x[n-1]

% filter coefficients
b = [0.5, 0.5]; % feedforward coefficients (Numerator)
a = 1;        % feedback coefficients (Denominator) - 1 for FIR

% plot frequency response
figure;
freqz(b, a, 1024);
title('Frequency Response of 2-Point Moving Average Filter');
if ~exist('../assets', 'dir')
    mkdir('../assets');
end
saveas(gcf, '../assets/moving_avg_freqz.png');

% plot pole-zero map
figure;
zplane(b, a);
title('Pole-Zero Plot of 2-Point Moving Average Filter');
saveas(gcf, '../assets/moving_avg_zplane.png');
