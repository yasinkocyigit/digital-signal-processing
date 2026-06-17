# fir filtre tasarimi ve pencereleme yontemleri

sayisal sinyal islemede, belirli spektral kriterleri (kesim frekansi, gecis bandi genisligi, durdurma bandi bastirmasi) saglayan filtrelerin tasarimi kritik bir oneme sahiptir. bu bolumde, ideal filtre karakteristiklerinin sonlu sureli ve gerceklenebilir fir (sonlu durtu yaniti) yapilara donusturulmesini saglayan **pencereleme yontemi** (window method) incelenmektedir.

---

### 1. tasarim probleminin tanimi

hazir filtre fonksiyonlarinin kullanimi yerine, tasarim surecinde sistemin davranisini belirleyen uc ana parametre uzerinde durulmaktadir:
- **kesim frekansi ($f_c$):** filtrenin geciren ve durduran bantlari ayiran esik degeridir.
- **filtre mertebesi ($n$):** filtrenin katsayi sayisini belirler. mertebenin artmasi, gecis bandinin keskinlesmesini saglar ancak hesaplama karmasikligini ve grup gecikmesini artirir.
- **pencere fonksiyonu:** ideal durtu yanitinin sonlandirilmasinda kullanilan agirliklandirma fonksiyonudur.

---

### 2. pencereleme yontemi (window method)

ideal bir alcak geciren filtrenin frekans cevabi dikdortgen formdadir. bu cevabin ters fourier donusumu, zaman alaninda sonsuz uzanan bir $sinc$ fonksiyonudur:

$$h_{ideal}[n] = \frac{\sin(2\pi f_c n)}{\pi n}$$

bu sonsuz serinin gerceklenebilir hale getirilmesi icin belirli bir $n$ noktasinda kesilmesi ve bir $w[n]$ pencere fonksiyonu ile carpilmasi gerekmektedir:

$$h[n] = h_{ideal}[n] \cdot w[n]$$

#### temel pencere tipleri ve karakteristikleri
| pencere | ana lob genisligi | yan lob bastirmasi | uygulama alani |
| :--- | :--- | :--- | :--- |
| **rectangular** | $4\pi/n$ | -13 db | en keskin gecis, en dusuk bastirma |
| **hamming** | $8\pi/n$ | -43 db | genel amacli kullanim |
| **blackman** | $12\pi/n$ | -58 db | yuksek bastirma gerektiren durumlar |

---

### 3. muhendislik dengeleri ve tasarim kriterleri

filtre tasariminda "bedelsiz kazanc yoktur" ilkesi gecerlidir. tasarim parametreleri arasindaki etkilesimler su sekildedir:
- **gecis bandi ve mertebe iliskisi:** daha dar bir gecis bandi ($ \Delta f $) elde etmek icin filtre mertebesi ($n$) artirilmalidir. yaklasik iliski $ \Delta f \approx k \cdot f_s / n $ seklindedir ($k$ pencereye bagli bir sabittir).
- **gibbs olgusu:** ideal yanitin aniden kesilmesi, frekans cevabinda dalgalanmalara (ripple) neden olur. uygun pencere secimi ile bu dalgalanmalarin genligi kontrol altina makinmaktadir.

---

### 4. analiz ve gorsellestirme

tasarlanan fir filtrelerin performansini ve karakteristiklerini anlamak amaciyla gerceklestirilen analizler asagida sunulmaktadir.

#### filtre mertebesinin gecis bandina etkisi
fir filtre tasariminda mertebe (n), filtrenin gecis bandi keskinligini belirleyen temel parametredir. farkli mertebelerin (n=20 ve n=100) kesim frekansi civarindaki davranisi incelendiginde, mertebe arttikca gecis bandinin daraldigi ve filtrenin ideal dikdortgen cevaba daha yakin bir performans sergiledigi gozlemlenmektedir. db olcegindeki grafikler, yuksek mertebenin durdurma bandindaki bastirma etkisini ve gecis bolgesindeki keskinligi net bir sekilde ortaya koymaktadir. yuksek mertebeli filtreler daha secici bir yapi sunarken, beraberinde getirdikleri hesaplama maliyeti ve grup gecikmesi tasarim asamasinda dikkate alinmalidir.

<p align="center">
  <img src="assets/order_comparison.png" alt="mertebe karsilastirmasi" width="1200">
</p>

#### pencere fonksiyonlarinin yan lob bastirma performansi
pencere yonteminde tercih edilen fonksiyon tipi, ana lob genisligi ve yan lob seviyeleri arasindaki spektral dengeyi dogrudan etkilemektedir. dikdortgen (rectangular), hamming ve blackman pencerelerinin karsilastirmali analizi, her pencerenin farkli avantajlara sahip oldugunu gostermektedir. dikdortgen pencere en dar gecis bandini saglamasina ragmen yan lob bastirmasinda en dusuk performansi sergilerken, blackman penceresi yuksek yan lob bastirmasi sayesinde daha temiz bir durdurma bandi sunmakta ancak daha genis bir gecis bandina neden olmaktadir. bu durum, tasarimda dogruluk ve bastirma arasindaki temel muhendislik dengesini temsil eden kritik bir veridir.

<p align="center">
  <img src="assets/window_comparison.png" alt="pencere karsilastirmasi" width="1200">
</p>

#### zaman alaninda sinyal temizleme uygulamasi
teorik filtre tasariminin gercek bir sinyal uzerindeki etkinligi, zaman alanindaki degisimler uzerinden dogrulanmaktadir. yuksek frekansli gurultu bilesenleri iceren bir giris sinyali, tasarlanan alcak geciren filtreye tabi tutuldugunda, istenmeyen dalgalanmalarin buyuk oranda yok edildigi tespit edilmektedir. filtrelenmis cikista ana sinyal bileseninin korunmasi, tasarimda kullanilan katsayilarin spektral gereksinimleri karsilama noktasindaki basarisini kanitlamaktadir. bu uygulama, fir filtrelerin pratik sinyal isleme sureclerindeki gurultu temizleme kapasitesini somut bir sekilde gostermektedir.

<p align="center">
  <img src="assets/filtering_application.png" alt="sinyal filtreleme uygulamasi" width="1200">
</p>

---

### 5. matlab uygulama kodlari

asagidaki kod bloklari, tasarim sureclerinin gorsellestirilmesini ve sonuclarin kaydedilmesini saglamaktadir.

#### fir tasarim ve mertebe karsilastirmasi
```matlab
% fir_design_comparison.m
% farkli mertebe ve pencere secimlerinin frekans cevabina etkisi
clc; clear; close all;

fs = 2000; fc = 400; wn = fc / (fs/2);
n_low = 20; n_high = 100;

h_hamm = fir1(n_low, wn, 'low', hamming(n_low+1));
% detayli kod matlab/ klasorunde yer almaktadir
saveas(gcf, '../assets/design_analysis.png');
```

---

**onemli not:** tasarim asamasinda `fir1` fonksiyonu kullanildiginda, pencere uzunlugunun mertebeden bir fazla ($n+1$) olmasi gerektigi unutulmamalidir.
