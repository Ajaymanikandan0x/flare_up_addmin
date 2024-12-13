import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalPadding;
  static late double verticalPadding;
  static late bool isDesktop;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    isDesktop = screenWidth > 1024;
    horizontalPadding = isDesktop ? screenWidth * 0.1 : screenWidth * 0.05;
    verticalPadding = isDesktop ? screenHeight * 0.05 : screenHeight * 0.02;
  }

  // Font sizes
  static double get titleFontSize => isDesktop ? 28.0 : 20.0;
  static double get subtitleFontSize => isDesktop ? 20.0 : 16.0;
  static double get bodyFontSize => isDesktop ? 18.0 : 14.0;

  // Spacing
  static double get spacingHeight => isDesktop ? screenHeight * 0.03 : screenHeight * 0.025;
  static double get buttonHeight => isDesktop ? 70.0 : 55.0;

  // Image sizes
  static double get imageSize => isDesktop ? screenWidth * 0.15 : screenWidth * 0.2;

  // Border radius
  static double get borderRadius => isDesktop ? 16.0 : 8.0;

  // Utility for detecting small screens
  static bool get isSmallScreen => screenWidth <= 768;

  // Container max width for centering content
  static double get maxContainerWidth => isDesktop ? 800 : double.infinity;
}
