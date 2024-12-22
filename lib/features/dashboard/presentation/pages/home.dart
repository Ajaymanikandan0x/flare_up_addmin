import 'package:flutter/material.dart';

import '../../../../core/themes/app_palette.dart';
import '../../../../core/utils/responsive.dart';
import '../widgets/drawer.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Responsive utilities
    Responsive.init(context);

    return Scaffold(
      body: Row(
        children: [
          // Permanent Sidebar for larger screens
          if (Responsive.isDesktop) const AppDrawer(isPermanent: true),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Navigation Bar
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: AppPalette.darkCard,
                    border: Border(
                      bottom: BorderSide(
                        color: AppPalette.darkDivider,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Drawer toggle for smaller screens
                      if (!Responsive.isDesktop)
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.search,
                            color: AppPalette.darkText),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_none,
                            color: AppPalette.darkText),
                        onPressed: () {},
                      ),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppPalette.gradient2,
                      ),
                    ],
                  ),
                ),
                // Content Area
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: const Center(
                      child: Text(
                        'Content Area',
                        style: TextStyle(color: AppPalette.darkText),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Drawer for smaller screens
      drawer: Responsive.isSmallScreen ? const AppDrawer() : null,
    );
  }
}
