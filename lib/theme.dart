import 'package:flutter/material.dart';

const ink = Color(0xFF182C35);
const muted = Color(0xFF63757D);
const green = Color(0xFF16705B);
const mint = Color(0xFFEAF4EF);
const line = Color(0xFFE3EAE7);
const canvas = Color(0xFFF5F7F5);

final campusTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: green).copyWith(
    primary: green,
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: ink,
    outline: muted,
  ),
  scaffoldBackgroundColor: canvas,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: ink,
        letterSpacing: -1.2),
    headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: ink,
        letterSpacing: -.6),
    titleLarge:
        TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ink),
    titleMedium:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ink),
    bodyLarge: TextStyle(fontSize: 15, height: 1.65, color: muted),
    bodyMedium: TextStyle(fontSize: 14, height: 1.55, color: muted),
    labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ink,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
      side: const BorderSide(color: line),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: canvas,
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: line)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: line)),
  ),
  dividerTheme: const DividerThemeData(color: line, thickness: 1, space: 32),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.white,
    indicatorColor: mint,
  ),
);
