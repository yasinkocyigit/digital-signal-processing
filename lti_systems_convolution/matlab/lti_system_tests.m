% lti sistem ozellikleri ve durtu yaniti
% bu script, bir sistemin lineerlik ve zamanla degismezlik (lti) 
% ozelliklerini ve durtu yaniti (impulse response) kavramini inceler.

clc; clear; close all;

% durtu (impulse) ve durtu yaniti (h[n])
% bir lti sistem, durtu yaniti ile tam olarak tanimlanabilir.
N = 20;
n = 0:N-1;

% ornek bir fir sistemin katsayilari (durtu yaniti)
h_true = [0.2 0.6 0.2];

% durtu sinyali olusturma (delta[n])
delta = [1, zeros(1, N-1)];

% sistemin durtuye cevabi (konvolusyon)
% lti sistemde giris durtu ise cikti h[n] dizisidir.
y_impulse = conv(delta, h_true);

fprintf('Sistemin katsayilari (h): [%s]\n', num2str(h_true));
fprintf('Durtu yanitinin ilk 3 elemani: [%s]\n', num2str(y_impulse(1:3)));

% lineerlik testi (ornek: 3 ile carpma sistemi)
% t{ax1 + bx2} = at{x1} + bt{x2} saglanmalidir.
x1 = rand(1, 10);
x2 = rand(1, 10);
a = 2; b = 3;

% sistem: y[n] = 3 * x[n]
system_func = @(x) 3 * x;

out1 = system_func(a*x1 + b*x2);
out2 = a*system_func(x1) + b*system_func(x2);

if isequal(out1, out2)
    disp('Sistem lineerdir.');
else
    disp('Sistem lineer degildir.');
end

% zamanla degismezlik testi
% giris kaydirildiginda cikti da ayni oranda kaymalidir.
k = 2; % kaydirma miktari
x = [1 2 3 4 5];
x_shifted = [zeros(1, k), x];

y = system_func(x);
y_shifted_expected = [zeros(1, k), y];
y_shifted_actual = system_func(x_shifted);

if isequal(y_shifted_expected, y_shifted_actual)
    disp('Sistem zamanla degismezdir.');
else
    disp('Sistem zamanla degismez degildir.');
end
