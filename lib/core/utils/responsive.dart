import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalPadding;
  static late double verticalPadding;
  static late bool isDesktop;
  static late bool isTablet;
  static late bool isMobile;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    
    // Define breakpoints
    isDesktop = screenWidth >= 1024;
    isTablet = screenWidth >= 768 && screenWidth < 1024;
    isMobile = screenWidth < 768;
    
    // Adjust padding based on screen size
    horizontalPadding = isDesktop 
        ? screenWidth * 0.1 
        : isTablet 
            ? screenWidth * 0.08 
            : screenWidth * 0.05;
            
    verticalPadding = isDesktop 
        ? screenHeight * 0.05 
        : isTablet 
            ? screenHeight * 0.04 
            : screenHeight * 0.03;
  }

  // Utility getter for non-desktop screens
  static bool get isSmallScreen => !isDesktop;

  // Font sizes
  static double get titleFontSize => isDesktop ? 28 : isTablet ? 24 : 20;
  static double get subtitleFontSize => isDesktop ? 20 : isTablet ? 18 : 16;
  static double get bodyFontSize => isDesktop ? 16 : 14;

  // Spacing
  static double get spacingHeight => screenHeight * (isDesktop ? 0.03 : 0.02);
  static double get buttonHeight => isDesktop ? 56 : 48;

  // Container dimensions
  static double get sidebarWidth => isDesktop ? 250 : 200;
  static double get topBarHeight => isDesktop ? 64 : 56;
  static double get maxContentWidth => isDesktop ? 1200 : double.infinity;

  // Border radius
  static double get borderRadius => isDesktop ? 12 : 8;
}
