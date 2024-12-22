import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/routes/routs.dart';
import '../../../../core/themes/app_palette.dart';
import '../../../../core/widgets/logo_gradient.dart';
import 'drawer_list_tile.dart';
import '../../../events/presentation/bloc/event_category_bloc.dart';

class AppDrawer extends StatelessWidget {
  final bool isPermanent;

  const AppDrawer({
    super.key,
    this.isPermanent = false,
  });

  @override
  Widget build(BuildContext context) {
    final drawerWidth = isPermanent ? 300.0 : null;

    return Container(
      width: drawerWidth,
      decoration: const BoxDecoration(
        gradient: AppPalette.primaryGradient,
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        children: [
          if (isPermanent)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: LogoGradientText(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          DrawerListTile(
            icon: FontAwesomeIcons.gaugeHigh,
            title: 'Dashboard',
            onTap: () {},
          ),
          DrawerListTile(
            icon: FontAwesomeIcons.calendar,
            title: 'Your Events',
            onTap: () {},
          ),
          DrawerListTile(
            icon: FontAwesomeIcons.creditCard,
            title: 'Billing',
            onTap: () {},
          ),
          DrawerListTile(
            icon: FontAwesomeIcons.calendarPlus,
            title: 'Manage Event Categories',
            onTap: () => Navigator.pushNamed(context, AppRouts.eventCategory),
          ),
          DrawerListTile(
            icon: FontAwesomeIcons.gear,
            title: 'Settings',
            onTap: () {},
          ),
          const Divider(),
          const Text(
            'Account',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          DrawerListTile(
            icon: FontAwesomeIcons.user,
            title: 'Profile',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
