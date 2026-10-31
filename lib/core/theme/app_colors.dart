import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const solar = Color(0xFFFFC52E);
  static const gold = Color(0xFFFFB21F);
  static const glow = Color(0xFFFFE66D);
  static const white = Color(0xFFFFFFFF);
  static const mist = Color(0xFFF4F4F4);
  static const night = Color(0xFF25364A);
  static const muted = Color(0xFF667085);
  static const disabled = Color(0xFF9B9B9B);
  static const line = Color(0xFFE7E9EE);

  static const darkBackground = Color(0xFF141B24);
  static const darkSurface = Color(0xFF1E2A38);
  static const darkLine = Color(0xFF2E3C4C);
  static const darkText = Color(0xFFF4F6F8);

  static const success = Color(0xFF1E7A46);
  static const danger = Color(0xFFB42318);
  static const amberText = Color(0xFF8A5B00);

  static const headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [solar, gold],
  );
}
