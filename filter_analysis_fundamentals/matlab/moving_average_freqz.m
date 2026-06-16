clc; clear; close all
%% parametreler
Fs = 8000;
M_list = [5 11 21]; % farkli moving average uzunluklari

%% frekans cevabi cizimi
figure;
hold on
for i = 1:length(M_list)
    M = M_list(i);
    b = ones(1,M)/M;
    a = 1;
    [H,f] = freqz(b,a,2048,Fs);
    plot(f, abs(H), 'LineWidth', 1.3)
    
    % yaklasik ilk sifir
    f0 = Fs / M;
    yl = ylim;
    plot([f0 f0], yl, '--')
end
grid on; xlim([0 2500]); xlabel('Frequency (Hz)'); ylabel('|H(f)|')
title('Moving Average FIR: M degistikce frekans cevabi')
legend('M=5','M=5 f0','M=11','M=11 f0','M=21','M=21 f0')

saveas(gcf, '../assets/moving_average_m_effect.png');
