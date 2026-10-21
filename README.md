# Mobil-programlama--dev-5

## Kampüs · Profil

5. hafta ders notundaki Flutter, `StatefulWidget`, `setState`, form ve sayfa geçişi konularına uygun profil uygulaması. API, hesap veya uygulama sunucusu gerektirmez. Flutter'ın standart ikon paketi dışında ek çalışma zamanı paketi kullanmaz.

## Çalıştırma

Flutter SDK 3.24 veya üzeri (Dart 3.5+) kurulu olmalıdır.

```sh
flutter pub get
flutter run -d chrome
```

Web hedefi projeye dahildir. Android/iOS platform dosyaları gerektiğinde:

```sh
flutter create --platforms=android,ios --project-name kampus_profil .
flutter run
```

## Özellikler

- **Kullanıcı yenile:** Üç kurgusal yerel kullanıcı arasında döner; profil, eğitim ve iletişim bilgilerini `setState` ile birlikte günceller.
- **Mesaj / Mail:** Yenile butonunun yanından açılan, UBYS benzeri alıcı bilgili dialog; anlık mesaj ve e-posta sekmeleri, konu/içerik doğrulaması, saatli mesaj balonları.
- **Yalnızca UI:** “Gönder (demo)” içeriği anında yerel önizlemeye ekler. Gerçek mesaj, e-posta veya ağ isteği gönderilmez. Her önizleme “Gönderilmedi (demo)” olarak işaretlenir.
- **Taslaklar:** Sekmeler arasında ayrı tutulur. Yazılı taslak varken kapatma onay ister. Pencere kapandığında taslaklar ve önizlemeler silinir; kalıcı depolama yoktur.
- **Sayfalar:** Profil, Hakkında, İletişim, Misyon/Vizyon. 1050 px altında alt navbar, daha geniş ekranlarda üst menü; 850 px'den itibaren iki sütunlu profil; klavyeyle birlikte kaydırılabilen dialog.
- **Yerel veri:** İsimler, öğrenci numaraları ve telefonlar örnektir. E-posta adresleri `example.com` kullanır.

## Dosyalar

```text
lib/
  main.dart                    Uygulama başlangıcı
  theme.dart                   Renkler ve Material 3 teması
  models/profile.dart          Profil modeli ve örnek kullanıcılar
  screens/profile_shell.dart   State, yenileme ve responsive navbar
  screens/profile_pages.dart   Profil / Hakkında / İletişim / Misyon-Vizyon
  widgets/profile_card.dart    Profil kartı
  widgets/message_dialog.dart  Mesaj/e-posta formu ve yerel önizleme
  widgets/shared.dart          Ortak arayüz parçaları
test/profile_app_test.dart     Widget ve responsive testleri
```

## Kontrol

```sh
flutter analyze
flutter test
flutter build web
```
