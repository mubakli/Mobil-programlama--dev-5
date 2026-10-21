import 'package:flutter/material.dart';

import 'screens/profile_shell.dart';
import 'theme.dart';

void main() => runApp(const CampusApp());

class CampusApp extends StatelessWidget {
  const CampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kampüs · Profil',
      debugShowCheckedModeBanner: false,
      theme: campusTheme,
      home: const ProfileShell(),
    );
  }
}
