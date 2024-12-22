import 'package:flutter/material.dart';

class AppPalette {
  static const Color gradient1 = Color(0xFF439DFE);
  static const Color gradient2 = Color(0xFFF687FF);
  static const Color success = Color(0xFF4CAF50);
  static const Color payment = Color(0xFFEC441E);
  static const Color error = Colors.redAccent;
  static const Color info = Color(0xFF2196F3);

  static const Color darkBackground = Color(0xFF000000);
  static const Color darkCard = Color(0xFF1D2026);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkHint = Color(0xFF747688);
  static const Color darkDivider = Color(0xFF2C2C2C);

  static const Gradient primaryGradient = LinearGradient(
    colors: [gradient1, gradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkGradient = LinearGradient(
    colors: [darkCard, Color(0xFF2C2C2C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFF262626);
  static const Color shimmerHighlight = Color(0xFF3D3D3D);
}
