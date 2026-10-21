import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampus_profil/main.dart';

Future<void> launch(WidgetTester tester,
    {Size size = const Size(1200, 1000)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const CampusApp());
  await tester.pumpAndSettle();
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Büyütülmüş yazıda mobil menü ve mesaj formu taşmaz',
      (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await launch(tester, size: const Size(390, 844));
    expect(tester.takeException(), isNull);
    await tapVisible(tester, find.byKey(const Key('open-message')));
    expect(tester.takeException(), isNull);
    await tapVisible(tester, find.text('E-posta'));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'Kullanıcı yenile tüm profil alanlarını değiştirir ve sırayla döner',
      (tester) async {
    await launch(tester);
    expect(find.text('Deniz Yılmaz'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('refresh-user')));
    expect(find.text('Ece Demir'), findsOneWidget);
    expect(find.text('Yazılım Mühendisliği'), findsNWidgets(2));
    await tapVisible(tester, find.byKey(const Key('refresh-user')));
    expect(find.text('Mert Kaya'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('refresh-user')));
    expect(find.text('Deniz Yılmaz'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Masaüstü menüde ek sayfalar ve iletişim alıcısı çalışır',
      (tester) async {
    await launch(tester);
    await tapVisible(tester, find.widgetWithText(TextButton, 'Hakkında'));
    expect(find.text('Nasıl çalışırım?'), findsOneWidget);
    await tapVisible(
        tester, find.widgetWithText(TextButton, 'Misyon / Vizyon'));
    expect(find.text('Misyonum'), findsOneWidget);
    expect(find.text('Vizyonum'), findsOneWidget);
    await tapVisible(tester, find.widgetWithText(TextButton, 'İletişim'));
    expect(find.text('deniz.yilmaz@example.com'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('refresh-user')));
    expect(find.text('ece.demir@example.com'), findsOneWidget);
    await tapVisible(tester, find.text('E-posta yaz'));
    expect(find.byKey(const Key('mail-subject')), findsOneWidget);
    expect(find.text('Ece Demir'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Boş mesaj engellenir, mesaj anlık yerel önizlemede görünür',
      (tester) async {
    await launch(tester);
    await tapVisible(tester, find.byKey(const Key('open-message')));
    await tapVisible(tester, find.byKey(const Key('send-preview')));
    expect(find.text('Lütfen bir mesaj yazın.'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('message-body')),
        'Merhaba, proje hakkında görüşebilir miyiz?');
    await tapVisible(tester, find.byKey(const Key('send-preview')));
    expect(find.text('Merhaba, proje hakkında görüşebilir miyiz?'),
        findsOneWidget);
    expect(find.textContaining('Gönderilmedi (demo)'), findsOneWidget);
    expect(find.text('Arayüz demosu · Gerçek mesaj veya e-posta gönderilmez.'),
        findsOneWidget);
    await tapVisible(tester, find.byTooltip('Pencereyi kapat'));
    await tapVisible(tester, find.byKey(const Key('open-message')));
    expect(
        find.text('Merhaba, proje hakkında görüşebilir miyiz?'), findsNothing);
  });

  testWidgets('E-posta konu doğrulaması ve ayrı kanal önizlemesi',
      (tester) async {
    await launch(tester);
    await tapVisible(tester, find.byKey(const Key('open-message')));
    await tapVisible(tester, find.text('E-posta'));
    await tester.enterText(
        find.byKey(const Key('mail-body')), 'Ders projesi için yazıyorum.');
    await tapVisible(tester, find.byKey(const Key('send-preview')));
    expect(find.text('Lütfen bir konu yazın.'), findsOneWidget);
    await tester.enterText(
        find.byKey(const Key('mail-subject')), 'Mobil programlama');
    await tapVisible(tester, find.byKey(const Key('send-preview')));
    expect(find.text('Mobil programlama'), findsOneWidget);
    expect(find.text('Ders projesi için yazıyorum.'), findsOneWidget);
    await tapVisible(tester, find.text('Anlık mesaj'));
    expect(find.text('Ders projesi için yazıyorum.'), findsNothing);
  });

  testWidgets('Taslak kanallar arasında korunur, kapatmada onay alınır',
      (tester) async {
    await launch(tester);
    await tapVisible(tester, find.byKey(const Key('open-message')));
    await tester.enterText(
        find.byKey(const Key('message-body')), 'Taslak mesaj');
    await tapVisible(tester, find.text('E-posta'));
    await tapVisible(tester, find.text('Anlık mesaj'));
    expect(find.text('Taslak mesaj'), findsOneWidget);
    await tapVisible(tester, find.byTooltip('Pencereyi kapat'));
    expect(find.text('Taslak silinsin mi?'), findsOneWidget);
    await tapVisible(tester, find.text('Yazmaya devam et'));
    expect(find.text('Taslak mesaj'), findsOneWidget);
    await tapVisible(tester, find.byTooltip('Pencereyi kapat'));
    await tapVisible(tester, find.text('Taslağı sil'));
    expect(find.byType(Dialog), findsNothing);
  });

  for (final width in [320.0, 390.0, 768.0, 850.0]) {
    testWidgets('$width px genişlikte sayfalar ve dialog taşmaz',
        (tester) async {
      await launch(tester, size: Size(width, 844));
      expect(tester.takeException(), isNull);
      if (width < 850) {
        expect(find.byType(NavigationBar), findsOneWidget);
        for (var i = 1; i < 4; i++) {
          await tester.tap(find.byType(NavigationDestination).at(i));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      }
      await tapVisible(tester, find.byKey(const Key('open-message')));
      expect(tester.takeException(), isNull);
      await tapVisible(tester, find.text('E-posta'));
      expect(tester.takeException(), isNull);
      // Klavye açıldığında dialog içeriği kaydırılabilir kalmalı.
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('mail-body')), 'Mobil test');
      await tapVisible(tester, find.byKey(const Key('send-preview')));
      expect(find.text('Lütfen bir konu yazın.'), findsOneWidget);
      expect(tester.takeException(), isNull);
      tester.view.resetViewInsets();
    });
  }
}
