% Projedeki tüm analiz adımlarını doğru sırayla çalıştırır.

code_klasoru = fileparts(mfilename('fullpath'));
cd(code_klasoru);

disp('Sayısal işaret işleme analizi başlatılıyor...');

run('adim01_veri_ve_onisleme.m');
run('adim02_fft_analizi.m');
run('adim03_psd_welch.m');
run('adim04_filtre_tasarimi.m');
run('adim05_karsilastirma.m');
run('adim06_stft_spektrogram.m');
run('adim07_farkli_ses_testi.m');

disp('Tüm analiz adımları tamamlandı.');
