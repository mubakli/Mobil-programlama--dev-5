import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../theme.dart';
import 'shared.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key, required this.profile, required this.onContact});
  final Profile profile;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: line)),
        child: Column(children: [
          SizedBox(
            height: 170,
            child: Stack(children: [
              Positioned.fill(
                  bottom: 42, child: CustomPaint(painter: _CoverPainter())),
              const Positioned(
                  top: 19,
                  left: 22,
                  child: Text('BİRLİKTE ÖĞREN, BİRLİKTE ÜRET.',
                      style: TextStyle(
                          color: Color(0xFFC2D9CE),
                          fontSize: 9,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600))),
              Positioned(
                  bottom: 0,
                  left: 24,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 43,
                      backgroundColor: Color(profile.color),
                      child: Text(profile.initials,
                          style: const TextStyle(
                              color: green,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1)),
                    ),
                  )),
              Positioned(
                  bottom: 10,
                  right: 22,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: mint, borderRadius: BorderRadius.circular(20)),
                    child: const Text('Öğrenci',
                        style: TextStyle(
                            color: green,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  )),
            ]),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(24, 15, 24, 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.name,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 5),
                    Text(profile.department,
                        style: const TextStyle(color: muted, fontSize: 13)),
                    const SizedBox(height: 10),
                    Row(children: [
                      const Icon(Icons.location_on_outlined,
                          size: 15, color: muted),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(profile.location,
                              style:
                                  const TextStyle(fontSize: 12, color: muted)))
                    ]),
                    const Divider(),
                    const Text('İLGİ ALANLARI',
                        style: TextStyle(
                            color: muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.4)),
                    const SizedBox(height: 12),
                    Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: profile.skills
                            .map((skill) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: canvas,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Text(skill,
                                      style: const TextStyle(
                                          fontSize: 11, color: ink)),
                                ))
                            .toList()),
                    const Divider(),
                    const InfoRow(
                        icon: Icons.school_outlined,
                        label: 'Öğrenim durumu',
                        value: 'Lisans / Ön lisans öğrencisi'),
                    InfoRow(
                        icon: Icons.badge_outlined,
                        label: 'Öğrenci numarası',
                        value: profile.studentNumber),
                    const SizedBox(height: 15),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                            onPressed: onContact,
                            icon: const Icon(Icons.alternate_email_rounded,
                                size: 17),
                            label: const Text('İletişim bilgileri'))),
                  ])),
        ]),
      );
}

class _CoverPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFF164C40));
    final paint = Paint()
      ..color = const Color(0xFF306354)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(
          Offset(size.width * .9, size.height * 1.1), 35.0 + i * 25, paint);
    }
    canvas.drawCircle(Offset(size.width * .63, 62), 4,
        Paint()..color = const Color(0xFFADCAA5));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CoverPainter oldDelegate) => false;
}
