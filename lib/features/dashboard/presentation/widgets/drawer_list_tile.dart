import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/themes/app_palette.dart';
import '../../../../core/themes/text_theme.dart';
import '../../../../core/utils/responsive.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize responsive utilities
    Responsive.init(context);

    // Calculate responsive values
    final iconSize = Responsive.isDesktop ? 24.0 : 20.0;
    final horizontalPadding = Responsive.isDesktop ? 16.0 : 8.0;
    final verticalPadding = Responsive.isDesktop ? 8.0 : 4.0;
    final fontSize = Responsive.isDesktop ? 18.0 : 16.0;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      leading: FaIcon(
        icon,
        color: AppPalette.darkText,
        size: iconSize,
      ),
      title: Text(
        title,
        style: AppTextStyles.primaryTextTheme(fontSize: fontSize),
      ),
      onTap: onTap,
    );
  }
}
