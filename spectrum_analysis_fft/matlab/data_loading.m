%% Veri Yukleme ve On Isleme Sablonu
% Bu script, WAV ve MAT dosyalarini okumak ve zaman ekseni kurmak icin tasarlanmistir.

%% 1. WAV Dosyasi Okuma
wavFile = "../../data/euphoric.wav"; % Proje kok dizinindeki data klasoru
if exist(wavFile, 'file')
    [x, Fs] = audioread(wavFile);

    % Stereo ise mono yap (kanallarin ortalamasini al)
    if size(x, 2) > 1
        x = mean(x, 2);
    end

    N = numel(x);
    t = (0:N-1)/Fs;

    fprintf("WAV: Fs=%d Hz | N=%d | Sure=%.2f s\n", Fs, N, N/Fs);

    % Zaman Domeni Plot (Ilk 5 saniye)
    figure;
    plot(t, x); grid on;
    xlabel("Zaman (s)"); ylabel("Genlik");
    title("Ses Sinyali - Zaman Domeni");
    xlim([0, min(5, max(t))]);
else
    fprintf("Uyari: %s dosyasi bulunamadi. Lutfen 'data' klasorunu kontrol edin.\n", wavFile);
end

%% 2. CWRU MAT Dosyasi Okuma
matFile = "../../data/B007_1_123.mat"; % Proje kok dizinindeki data klasoru
if exist(matFile, 'file')

    S = load(matFile);
    
    % Degisken adlarini listele
    fn = fieldnames(S);
    disp("MAT Dosyasi Icerigi:");
    disp(fn);
    
    % Ornek kanal secimi (Drive End)
    % Not: CWRU veri setinde Fs genellikle 12k veya 48k'dir.
    x_de = S.(fn{1}); % Ilk degiskeni secelim (genelde veri budur)
    Fs_mat = 48000; 
    
    N_mat = numel(x_de);
    t_mat = (0:N_mat-1)/Fs_mat;
    
    fprintf("MAT: Fs=%d Hz | N=%d | Sure=%.2f s\n", Fs_mat, N_mat, N_mat/Fs_mat);
    
    % Zaman Domeni Plot (Ilk 0.05 saniye)
    figure;
    plot(t_mat, x_de); grid on;
    xlabel("Zaman (s)"); ylabel("Ivme");
    title("Titresim Sinyali (DE) - Zaman Domeni");
    xlim([0, 0.05]);
else
    fprintf("Uyari: %s dosyasi bulunamadi.\n", matFile);
end

%% 3. Grafikleri Kaydetme
% Assets klasorunun varligini kontrol et ve grafikleri kaydet
if ~exist('../assets', 'dir')
    mkdir('../assets');
end

% Acik olan tum figurleri kaydet
figs = findobj('Type', 'figure');
for i = 1:length(figs)
    filename = sprintf('../assets/data_plot_%d.png', i);
    saveas(figs(i), filename);
end
