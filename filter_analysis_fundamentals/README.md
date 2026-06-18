# Filtre Analizi ve Frekans Cevabı Temelleri

Sinyal işleme zincirinin gözlem aşamasından müdahale aşamasına geçişi bu bölümde ele alınmaktadır. FFT ile sinyalin içindeki frekans bileşenleri tespit edildikten sonra bir sonraki soru şu olmaktadır: bir sistem bu frekanslara ne yapar? Bu sorunun yanıtı **frekans cevabı** $H(e^{j\omega})$ kavramında yatmaktadır.

---

## 1. Filtreleme: Frekans Seçiminin Matematiği

Sinyal işleme zincirinin gözlem aşamasından (FFT ile sinyaldeki frekans bileşenlerini tespit etme) müdahale aşamasına geçişi bu bölümde ele alınmaktadır. İlk haftalarda bir sinyalin içinde hangi frekansların olduğunu anlamaya çalışırken (FFT çizme, ekseni doğru kurma, çözünürlük, leakage ve pencereleme kavramları), bu hafta artık sadece sinyale bakmakla kalmayıp, sinyale etki eden sistemi yani **filtreyi** konuşacağız.

Buradaki ana fikir şudur: Bir filtreyi zaman alanında 'sinyali değiştiriyor' diye görürüz; ancak asıl net açıklama frekans alanında gelir. Çünkü filtre dediğimiz şey aslında bazı frekansları geçirir, bazılarını bastırır. Yani filtre, frekans seçen bir mekanizmadır. Örneğin, düşük frekansları koruyup yüksek frekansları bastırıyorsa "alçak geçiren (low-pass)" denir; tam tersini yapıyorsa "yüksek geçiren (high-pass)"; belirli bir aralığı geçiriyorsa "bant geçiren (band-pass)"; çok dar, rahatsız edici bir frekansı söndürüyorsa "çentik (notch)" filtre olarak adlandırılır.

LTI (Lineer Zamanla Değişmeyen) varsayımı altında, frekans alanındaki giriş-çıkış ilişkisi son derece yalın bir çarpım olarak ifade edilir:

$$Y(e^{j\omega}) = H(e^{j\omega}) \cdot X(e^{j\omega})$$

Bu formül çok güçlüdür çünkü bize şunu söyler: sistem (filtre), frekans alanında girişe 'çarpan' gibi davranır. Yani $H(e^{j\omega})$ değeri büyük olan frekanslarda sinyal geçer, küçük olduğu frekanslarda ise sinyal bastırılır. Zaman alanındaki karmaşık görünen birçok filtre davranışı, frekans alanında çok daha sade anlaşılır hale gelir. Sinyali analiz etmek için FFT kullanırken, sistemi (filtreyi) analiz etmek için frekans cevabı kullanılır. Bu ikisi birleşince, filtreleme sonrası ne olacağını öngörebiliriz.

**Sayısal Örnek:** $x[n] = \sin(2\pi \cdot 50 \cdot t) + 0.4\sin(2\pi \cdot 400 \cdot t)$ sinyaline basit bir alçak geçiren filtre uygulandığında, frekans alanında $50\,\text{Hz}$ bileşeninin büyük ölçüde korunduğu, $400\,\text{Hz}$ bileşeninin ise küçüldüğü gözlemlenir. Zaman alanında ise sinyalin daha 'yumuşak' hale geldiği görülür. Bu durum, filtreleme davranışının frekans alanında nasıl kontrol edildiğinin ve yorumlandığının doğrudan bir kanıtıdır.

<p align="center">
  <img src="assets/filter_intro_spectrum.png" alt="Filtre Giriş-Çıkış Spektrumu" width="1200">
  <br>
  <em>Görsel 1: Birbirine yakın iki frekanslı sentetik sinyalin zaman alanı (üst) ve frekans alanı (alt) görünümü. FFT ekseninde 50 Hz ve 400 Hz tepeleri belirgin şekilde ayrışmaktadır. Alçak geçiren filtre uygulandığında 400 Hz tepesi belirgin biçimde küçülürken 50 Hz tepesi korunur; bu frekans alanındaki $Y = H \cdot X$ çarpımının doğrudan görsel doğrulamasıdır.</em>
</p>


---

## 2. Temel Filtre Türleri

Uygulama gereksinimlerine göre dört temel filtre tipi tanımlanmaktadır:

| Filtre Tipi | Geçirilen Band | Bastırılan Band | Tipik Kullanım |
|:---|:---|:---|:---|
| **Low-Pass** | Düşük frekanslar | Yüksek frekanslar | Gürültü yumuşatma, sensör verisi |
| **High-Pass** | Yüksek frekanslar | Düşük frekanslar | DC drift giderimi, trend temizliği |
| **Band-Pass** | Belirli bir aralık | Aralık dışı | Belirli bir mekanik bileşeni izolasyon |
| **Notch** | Tümü (dar bant hariç) | Dar bant | 50/60 Hz şebeke gürültüsü |

---

## 3. Transfer Fonksiyonu ve Birim Çember

Dijital filtrelerin matematiksel modeli $H(z)$ transfer fonksiyonu ile tanımlanır. Sistemin frekans cevabı, transfer fonksiyonunun Z-düzleminde yarıçapı 1 olan **birim çember** üzerindeki değerlerine karşılık gelir:

$$H(e^{j\omega}) = H(z)\big|_{z = e^{j\omega}}$$

Bu ifadenin sezgisel açıklaması şudur: $z = e^{j\omega}$ yerine koyarak $\omega$'yı $0$'dan $\pi$'ye taradığımızda, sistemin DC bileşeninden Nyquist frekansına kadar her frekansta nasıl davrandığı okunur.

**Basit FIR Örneği:** $y[n] = \frac{1}{2}x[n] + \frac{1}{2}x[n-1]$ sisteminde transfer fonksiyonu:

$$H(z) = \frac{1}{2}(1 + z^{-1})$$

Frekans cevabı için $z = e^{j\omega}$ yazılırsa:

$$H(e^{j\omega}) = \frac{1}{2}(1 + e^{-j\omega})$$

$\omega = 0$ (DC)'de: $|H(1)| = 1$ → tam geçiriyor.  
$\omega = \pi$ (Nyquist)'de: $|H(-1)| = 0$ → tamamen bastırıyor. Bu, alçak geçiren davranışın matematiksel kanıtıdır.

---

## 4. FIR ve IIR Filtre Yapıları

### 4.1. FIR (Sonlu Dürtü Yanıtı)

Geri besleme içermeyen yapılardır; çıkış yalnızca girişin geçmiş örneklerine bağlıdır:

$$y[n] = \sum_{k=0}^{M} b_k x[n-k]$$

MATLAB'da $a = 1$ vektörüyle tanımlanır. Her zaman kararlıdır ve lineer faz karakteristiği elde etmek daha kolaydır. Dürtü yanıtı $M+1$ örnek sonra sona erer.

### 4.2. IIR (Sonsuz Dürtü Yanıtı)

Geri besleme içeren yapılardır; çıkış hem giriş örneklerine hem de geçmiş çıkış değerlerine bağlıdır:

$$y[n] = \sum_{k=0}^{M} b_k x[n-k] - \sum_{m=1}^{P} a_m y[n-m]$$

MATLAB'da $a$ vektörü birden fazla katsayı içerir ($[1,\, -a_1,\, -a_2,\,\ldots]$ biçiminde). Daha az katsayıyla daha keskin frekans seçiciliği sağlanabilir; ancak kutup konumlarına bağlı kararlılık analizi zorunludur.

<p align="center">
  <img src="assets/fir_vs_iir_comparison.png" alt="FIR vs IIR Kıyaslaması" width="1200">
  <br>
  <em>Görsel 2: Aynı giriş sinyaline uygulanan FIR (9-noktalı hareketli ortalama) ve IIR (birinci dereceden, $\alpha = 0.85$) filtrelerinin karşılaştırması. Üst grafik zaman alanı çıkışlarını, ikinci grafik dürtü yanıtlarını, üçüncü grafik freqz ile elde edilen frekans cevaplarını, alt grafik ise giriş ve çıkış spektrumlarını göstermektedir. IIR filtresinin dürtü yanıtının sonsuza uzadığı (yavaş sönüm), FIR filtresinin ise belirli bir süre sonra sona erdiği açıkça gözlemlenmektedir.</em>
</p>

---

## 5. Moving Average Filtresi: Frekans Cevabı Analizi

$M$-noktalı hareketli ortalama filtresi, basit bir FIR alçak geçiren yapısıdır:

$$y[n] = \frac{1}{M}\sum_{k=0}^{M-1} x[n-k] \implies H(z) = \frac{1}{M}\sum_{k=0}^{M-1} z^{-k}$$

Frekans cevabı sinc-benzeri bir profil sergiler. **İlk sıfır frekansı** yaklaşık olarak:

$$f_0 \approx \frac{F_s}{M}$$

konumunda oluşur. Bu kuralın önemi şudur: $M$ arttıkça ilk sıfır daha sola kayar, filtre daha agresif alçak geçiren karakteri kazanır.

**Sayısal Örnek:** $F_s = 8\,000\,\text{Hz}$ ve $M = 11$ için $f_0 \approx 727\,\text{Hz}$. Bu değerin altında kalan bir $200\,\text{Hz}$ bileşeni neredeyse dokunulmadan geçerken, $f_0$'a yakın olan $600\,\text{Hz}$ bileşeni ciddi biçimde zayıflatılır. $M = 5$ seçildiğinde $f_0 \approx 1600\,\text{Hz}$'ye çıkar ve $600\,\text{Hz}$ bileşeni korunur; ancak gürültü azaltma kapasitesi de düşer. Bu durum $M$ seçiminin salt bir "kaç örnek ortalayayım?" sorusu değil, bir frekans tasarım kararı olduğunu ortaya koymaktadır.

<p align="center">
  <img src="assets/moving_average_m_effect.png" alt="Moving Average M Etkisi" width="1200">
  <br>
  <em>Görsel 3: Farklı $M$ değerleri ($M = 5, 11, 21$) için freqz ile hesaplanan hareketli ortalama filtresi frekans cevapları. Kesik dikey çizgiler yaklaşık ilk sıfır konumlarını ($f_0 \approx F_s/M$) işaretlemektedir. $M$ arttıkça eğri sola kayar: geçirme bandı daralır ve yüksek frekanslar daha erken bastırılmaya başlar. Bu gözlem, süreç tasarımında $M$ seçiminin nasıl bir mühendislik dengesi gerektirdiğini somut biçimde göstermektedir.</em>
</p>

---

## 6. Gerçek Veri Uygulamaları

### 6.1. Ses Verisi Filtreleme

Ses sinyaline Butterworth alçak geçiren ($f_c = 1500\,\text{Hz}$) ve yüksek geçiren ($f_c = 300\,\text{Hz}$) filtreler uygulanmıştır.

<p align="center">
  <img src="assets/audio_filtering_results.png" alt="Ses Filtreleme" width="1200">
  <br>
  <em>Görsel 4: Ses verisi üzerinde alçak geçiren ve yüksek geçiren filtre uygulaması. Üst grafik her iki filtrenin frekans cevaplarını ($|H(f)|$) göstermekte olup kesişim bölgesi transfer fonksiyonlarının taraştığı yeri işaretlemektedir. Orta grafik zaman alanı sinyalini gösterir; alçak geçirenin çıkışı daha yumuşakken yüksek geçirenin çıkışı daha titreşimli görünmektedir. Alt grafik spektral değişimi doğrulamaktadır: alçak geçiren $1500\,\text{Hz}$ üzerini bastırırken yüksek geçiren $300\,\text{Hz}$ altını bastırmıştır.</em>
</p>

### 6.2. Motor Verisi Filtreleme

CWRU motor titreşim verisinde baskın frekans bileşeni band-pass ile izole edilmiş, ardından Notch filtresiyle hedeflenen tepe noktası bastırılmıştır.

<p align="center">
  <img src="assets/motor_filtering_results.png" alt="Motor Filtreleme" width="1200">
  <br>
  <em>Görsel 5: Motor titreşim verisi üzerinde band-pass ve notch filtre zincirleme uygulaması. Spektral analizde baskın olan frekans bileşeni önce band-pass ile izole edilmiş; ardından notch filtresiyle o dar bandın bastırıldığı doğrulanmıştır. Zaman alanında filtreleme öncesi ve sonrası genlik farkı, filtrenin etkinliğini gözlemsel olarak doğrulamaktadır.</em>
</p>

---

## Uygulama Notları

- Filtre tasarımı öncesinde `pwelch` ya da `periodogram` ile spektrum analizi yapılarak hedef frekanslar belirlenmelidir.
- FIR filtreler ($a = 1$) kararlılık garantisi sunarken, IIR filtreler hesaplama verimliliği sağlar.
- Notch filtre tasarımında kutup yarıçapı $r$ parametresi bastırma bandının genişliğini doğrudan belirler ($r \to 1$ → daha dar notch).
- Tüm filtreleme işlemlerinde sinyal başlangıcındaki geçici rejim (transient) uzunluğu filtrenin mertebesine bağlıdır ve yorumlarda dikkate alınmalıdır.
