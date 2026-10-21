import 'package:flutter/material.dart';

import '../theme.dart';

class Panel extends StatelessWidget {
  const Panel({super.key, required this.child, this.padding = 26});
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: line),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      );
}

class SectionHeading extends StatelessWidget {
  const SectionHeading(
      {super.key, required this.icon, required this.title, this.caption});
  final IconData icon;
  final String title;
  final String? caption;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: mint, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: green, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              if (caption != null)
                Text(caption!,
                    style: const TextStyle(fontSize: 12, color: muted)),
            ]),
          ),
        ],
      );
}

class InfoRow extends StatelessWidget {
  const InfoRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 19, color: muted),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(label, style: const TextStyle(fontSize: 12, color: muted)),
                const SizedBox(height: 3),
                SelectableText(value,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500, color: ink)),
              ])),
        ]),
      );
}

class DemoNote extends StatelessWidget {
  const DemoNote({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration:
            BoxDecoration(color: mint, borderRadius: BorderRadius.circular(12)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.info_outline_rounded, size: 18, color: green),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
            compact
                ? 'Arayüz demosu · Gerçek mesaj veya e-posta gönderilmez.'
                : 'Burası bir arayüz demosudur. Profil bilgileri kurgusaldır; mesajlar ve e-postalar yalnızca yerel önizlemede gösterilir.',
            style: const TextStyle(color: green, fontSize: 12, height: 1.5),
          )),
        ]),
      );
}
