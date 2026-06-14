# Spektrum Analizi ve FFT Temelleri

Bu çalışma, ham veri setlerinin dijital sinyal işleme (DSP) standartlarına uygun hale getirilmesi, örnekleme teorisinin pratik yansımaları ve Hızlı Fourier Dönüşümü (FFT) kullanılarak frekans alanı analizinin gerçekleştirilmesi süreçlerini ele almaktadır.

---

## 1. Veri Hazırlama ve Ön İşleme Standartları

DSP süreçlerinde analiz başarısı, verinin doğru tanımlanmasına bağlıdır. Ham veriler (WAV, MAT vb.) spektral analize tabi tutulmadan önce aşağıdaki kontrol listesi üzerinden normalize edilmelidir:

*   **Kanal Belirleme:** Çok kanallı verilerde (stereo ses veya çok eksenli ivmeölçer) analize uygun kanalın seçilmesi veya kanalların ortalamasının alınması.
*   **Örnekleme Frekansı ($F_s$) Doğrulaması:** Zaman ve frekans eksenlerinin hatalı ölçeklenmesini önlemek adına $F_s$ değerinin kesinleştirilmesi.
*   **DC Offset Giderimi:** Sensörlerden gelen verilerdeki statik kaymaların (ortalama değerin sıfırdan sapması) spektrumda 0 Hz noktasında yapay bir tepe oluşturmaması için veriden ortalamanın çıkarılması.

---

## 2. Temel Teorik Kavramlar ve Matematiksel Modeller

### 2.1. Zaman Alanı ve Örnekleme
Ayrık zamanlı bir sinyalin zaman ekseni, örnekleme frekansına ($F_s$) bağlı olarak inşa edilir. $n$ örnek indisini temsil etmek üzere, her bir örneğin zaman karşılığı şu formülle ifade edilir:

$$t[n] = \frac{n}{F_s}$$

> **Örnek:** $F_s = 48000$ Hz (48 kHz) olan bir sistemde 48000. örnek ($n=47999$), tam olarak 1. saniyeye karşılık gelmektedir. $F_s$ değerindeki bir hata, sinyalin hızının veya süresinin yanlış yorumlanmasına yol açar.

### 2.2. Nyquist Teoremi ve Aliasing (Örtüşme)
Sinyaldeki en yüksek frekans bileşeninin ($f_{max}$) bilgi kaybı olmaksızın dijitalleştirilebilmesi için örnekleme hızının en az iki katı olması gerekmektedir. Nyquist sınırı şudur:

$$f_N = \frac{F_s}{2}$$

Eğer sinyalde $f_N$ değerinden daha yüksek frekanslı bileşenler bulunuyorsa, bu bileşenler düşük frekans bölgesine "katlanarak" (aliasing) hatalı sonuçlar üretir.

> **Örnek:** 6 kHz'lik bir sinüs dalgası 8 kHz örnekleme hızıyla ($F_s=8000$, $f_N=4000$) örneklenirse, sinyal 2 kHz ($|8000 - 6000|$) olarak gözlemlenir.

![Aliasing Demo](assets/aliasing_demo.png)
*Görsel: Yüksek frekanslı bir sinyalin yetersiz örnekleme nedeniyle düşük frekanslı görünmesi (Aliasing).*

### 2.3. Frekans Çözünürlüğü ($\Delta f$)
FFT analizinde birbirine yakın iki frekans bileşenini ayırt edebilme kabiliyeti, analiz edilen verinin toplam süresine ($T$) bağlıdır.

$$\Delta f = \frac{F_s}{N} = \frac{1}{T}$$

> **Örnek:** 0.25 saniyelik bir ses kaydında çözünürlük 4 Hz iken, kayıt süresi 1 saniyeye çıkarıldığında çözünürlük 1 Hz'e iyileşir. Daha ince detaylar için daha uzun veri kaydı esastır.

---

## 3. FFT Analizi ve Spektrum Okuma

### 3.1. Frekans Ekseni Kurulumu
FFT çıktısı doğrudan frekans değerlerini (Hz) vermez; sonuçlar "bin" adı verilen kutucuklarda döner. Bu bin'lerin frekans karşılığı manuel olarak oluşturulur:

$$f[k] = k \cdot \frac{F_s}{N}$$

Burada $k$, $0$ ile $N/2$ (Nyquist) arasındaki bin indisidir.

### 3.2. Tek Taraflı Spektrum ve Genlik Düzeltme ($2\times$ Kuralı)
Gerçek sayılı sinyallerin spektrumu simetriktir (negatif ve pozitif frekanslar birbirinin aynasıdır). Pratik analizlerde sadece pozitif taraf ($0 \dots F_s/2$) kullanılır. Ancak enerjinin yarısı negatif tarafta kaldığı için, genlikleri doğru okumak adına DC (0 Hz) ve Nyquist frekansı hariç tüm bileşenler 2 ile çarpılır.

![FFT Spectrum](assets/fft_spectrum.png)
*Görsel: Genlik düzeltmesi yapılmış FFT spektrumu.*

---

## 4. Baskın Frekans (Peak) Analizi

Spektral analizin temel amacı, sinyaldeki baskın enerji yoğunluklarını tespit etmektir. Bir makine titreşim verisinde veya ses sinyalinde en yüksek genliğe sahip frekans, sistemin karakteristiği hakkında kritik bilgi sağlar.

*   **Dönel Makineler:** Peak frekansı genellikle RPM (dakikadaki devir sayısı) ile ilişkilidir.
*   **Elektriksel Gürültü:** Spektrumda 50 Hz veya 60 Hz'de görülen keskin tepeler şebeke gürültüsüne işaret eder.

---

## 5. Uygulama Kodu Şablonu (MATLAB)

Aşağıdaki yapı, FFT analizi için gereken adımları içermektedir:

```matlab
% 1. Veri Hazırlama
N = numel(x);
t = (0:N-1)/Fs;

% 2. FFT ve Normalizasyon
X = fft(x)/N;

% 3. Tek Taraflı Spektrum Oluşturma
K = floor(N/2) + 1;
X_single = X(1:K);
f = (0:K-1)*(Fs/N);

% 4. Genlik Düzeltme (2x)
mag = abs(X_single);
mag(2:end-1) = 2*mag(2:end-1);

% 5. Peak Tespiti
[peakVal, idx] = max(mag);
fprintf('Baskin Frekans: %.2f Hz\n', f(idx));
```

---

## Veri Kaynaklari
Analizlerde kullanilan ham verilere projenin kok dizinindeki `data/` klasorunden erisilebilir. Detayli bilgi icin [data/README.md](../data/README.md) dosyasini inceleyiniz.
