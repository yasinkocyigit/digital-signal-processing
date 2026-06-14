# Veri Setleri Teknik Detaylari

Bu klasor, analizlerde kullanilan ham verilerin teknik parametrelerini icermektedir.

### 1. euphoric.wav (Ses Verisi)
*   **Ornekleme Frekansi ($F_s$):** 48,000 Hz (48 kHz)
*   **Kanal Sayisi:** 2 (Stereo) - Islemlerde mono'ya donusturulmektedir.
*   **Bit Derinligi:** 16-bit PCM
*   **Kullanim Amaci:** Frekans cozunurlugu analizi, aliasing (ortusme) gosterimleri ve genel ses spektrumu incelemeleri.

### 2. B007_1_123.mat (Titresim Verisi)
*   **Kaynak:** Case Western Reserve University (CWRU) Rulman Veri Seti.
*   **Ornekleme Frekansi ($F_s$):** 48,000 Hz (48 kHz)
*   **Icerik:** `X123_DE_time` (Drive End titresim verisi) ve `X123_FE_time` (Fan End titresim verisi).
*   **Motor Yuku:** 1 HP
*   **Hata Capi:** 0.007 inch (Rulman bilye hatasi)
*   **Kullanim Amaci:** Makine titresim analizi, karakteristik hata frekanslarinin tespiti ve peak (tepe) frekans analizi.
