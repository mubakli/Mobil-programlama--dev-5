import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../theme.dart';
import '../widgets/shared.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage(
      {super.key,
      required this.profile,
      required this.onAbout,
      required this.onMessage});
  final Profile profile;
  final VoidCallback onAbout;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) => Column(children: [
        Panel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SectionHeading(
              icon: Icons.waving_hand_outlined,
              title: 'Tanıştığımıza memnun oldum.',
              caption: 'Kısaca ben'),
          const SizedBox(height: 21),
          Text(profile.about, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 13),
          TextButton.icon(
              onPressed: onAbout,
              label: const Text('Hakkımda daha fazlası'),
              icon: const Icon(Icons.arrow_forward_rounded, size: 17),
              iconAlignment: IconAlignment.end),
        ])),
        const SizedBox(height: 18),
        Panel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SectionHeading(
              icon: Icons.school_outlined,
              title: 'Eğitim bilgileri',
              caption: 'Öğrenme yolculuğum'),
          const SizedBox(height: 19),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: canvas, borderRadius: BorderRadius.circular(12)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.account_balance_outlined,
                  color: green, size: 28),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(profile.department,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 5),
                    Text('${profile.year}  ·  Öğrenim devam ediyor',
                        style: const TextStyle(fontSize: 12, color: muted)),
                  ])),
            ]),
          ),
          const SizedBox(height: 20),
          const Row(children: [
            Icon(Icons.auto_awesome_outlined, size: 17, color: green),
            SizedBox(width: 8),
            Expanded(
                child: Text('Bu dönem odağım: mobil uygulama geliştirme',
                    style: TextStyle(fontSize: 12, color: muted)))
          ]),
        ])),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: const Color(0xFFEBF0E8),
              borderRadius: BorderRadius.circular(18)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Güzel fikirler bir merhabayla başlar.',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: ink,
                    letterSpacing: -.4)),
            const SizedBox(height: 7),
            const Text('Bir proje, bir soru ya da sadece tanışmak için…',
                style: TextStyle(fontSize: 13, color: muted)),
            const SizedBox(height: 13),
            TextButton.icon(
                onPressed: onMessage,
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 17),
                label: const Text('Bir mesaj bırak')),
          ]),
        ),
      ]);
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) => Panel(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeading(
            icon: Icons.person_outline_rounded,
            title: 'Hakkımda',
            caption: 'Kodun arkasındaki insan'),
        const SizedBox(height: 24),
        Text(profile.about, style: Theme.of(context).textTheme.bodyLarge),
        const Divider(),
        Text('Nasıl çalışırım?',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        const Text(
            'Önce ihtiyacı dinler, sonra küçük adımlarla çözüm üretirim. Anlaşılır kod, sade tasarım ve geri bildirim benim için iyi bir projenin temelidir.'),
        const SizedBox(height: 24),
        Text('Şu sıralar', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        const _ValueItem(
            number: '01',
            title: 'Öğreniyorum',
            text: 'Flutter ile farklı ekranlara uyum sağlayan arayüzler.'),
        const _ValueItem(
            number: '02',
            title: 'Üretiyorum',
            text: 'Günlük yaşamı kolaylaştıran küçük mobil projeler.'),
        const _ValueItem(
            number: '03',
            title: 'Paylaşıyorum',
            text:
                'Ders notları, deneyimler ve birlikte geliştirdiğimiz fikirler.'),
      ]));
}

class ContactPage extends StatelessWidget {
  const ContactPage(
      {super.key,
      required this.profile,
      required this.onMessage,
      required this.onMail});
  final Profile profile;
  final VoidCallback onMessage;
  final VoidCallback onMail;

  @override
  Widget build(BuildContext context) => Column(children: [
        Panel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SectionHeading(
              icon: Icons.alternate_email_rounded,
              title: 'İletişim',
              caption: 'Bağlantıda kalalım'),
          const SizedBox(height: 22),
          const Text(
              'Sorularınız ve birlikte geliştirebileceğimiz fikirler için iletişime geçebilirsiniz.'),
          const SizedBox(height: 14),
          InfoRow(
              icon: Icons.mail_outline_rounded,
              label: 'E-posta',
              value: profile.email),
          InfoRow(
              icon: Icons.phone_outlined,
              label: 'Telefon (örnek)',
              value: profile.phone),
          InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Konum',
              value: profile.location),
          const Divider(),
          Wrap(spacing: 10, runSpacing: 10, children: [
            FilledButton.icon(
                onPressed: onMessage,
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 17),
                label: const Text('Anlık mesaj')),
            OutlinedButton.icon(
                onPressed: onMail,
                icon: const Icon(Icons.mail_outline_rounded, size: 17),
                label: const Text('E-posta yaz')),
          ]),
        ])),
        const SizedBox(height: 18),
        const DemoNote(),
      ]);
}

class MissionPage extends StatelessWidget {
  const MissionPage({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const Panel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SectionHeading(
              icon: Icons.near_me_outlined,
              title: 'Misyonum',
              caption: 'Bugün neden üretiyorum?'),
          SizedBox(height: 22),
          Text('Teknolojiyi herkes için daha anlaşılır ve ulaşılabilir kılmak.',
              style: TextStyle(
                  fontSize: 23,
                  height: 1.4,
                  color: ink,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -.6)),
          SizedBox(height: 14),
          Text(
              'Öğrendiklerimi gerçek ihtiyaçlara dönüştürerek insanların hayatını kolaylaştıran, erişilebilir ve güvenilir dijital deneyimler geliştirmek.'),
        ])),
        const SizedBox(height: 18),
        const Panel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SectionHeading(
              icon: Icons.explore_outlined,
              title: 'Vizyonum',
              caption: 'Yarın nereye ulaşmak istiyorum?'),
          SizedBox(height: 22),
          Text(
              'Birlikte öğrenen, birlikte değer üreten bir geleceğin parçası olmak.',
              style: TextStyle(
                  fontSize: 23,
                  height: 1.4,
                  color: ink,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -.6)),
          SizedBox(height: 14),
          Text(
              'Sürekli öğrenen bir geliştirici olarak, topluma fayda sağlayan sürdürülebilir projelerde çalışmak ve bilgi paylaşımını büyütmek.'),
        ])),
        const SizedBox(height: 18),
        Panel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Yolumu belirleyen değerler',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 15),
          const _ValueItem(
              number: '01',
              title: 'Merak',
              text: 'Her soruyu yeni bir öğrenme fırsatı olarak görmek.'),
          const _ValueItem(
              number: '02',
              title: 'Paylaşım',
              text: 'Bilgiyi ve deneyimi birlikte çoğaltmak.'),
          const _ValueItem(
              number: '03',
              title: 'Sorumluluk',
              text: 'İnsana, gizliliğe ve erişilebilirliğe saygı duymak.'),
        ])),
      ]);
}

class _ValueItem extends StatelessWidget {
  const _ValueItem(
      {required this.number, required this.title, required this.text});
  final String number;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(number,
              style: const TextStyle(
                  fontSize: 12, color: green, fontWeight: FontWeight.w600)),
          const SizedBox(width: 17),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 3),
                Text(text),
              ])),
        ]),
      );
}
