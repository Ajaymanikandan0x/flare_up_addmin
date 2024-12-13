import 'package:flutter/material.dart';
import 'package:flare_up_admin/core/themes/app_palette.dart';
import 'package:flare_up_admin/core/themes/text_theme.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.darkBackground,
      body: Row(
        children: [
          // Left Sidebar
          Container(
            width: 250,
            color: AppPalette.darkCard,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MeetMingle',
                  style: AppTextStyles.primaryTextTheme(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ).copyWith(color: AppPalette.gradient1),
                ),
                const SizedBox(height: 32),
                _buildMenuItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  isSelected: false,
                ),
                _buildMenuItem(
                  icon: Icons.event,
                  label: 'Your Events',
                  isSelected: true,
                ),
                _buildMenuItem(
                  icon: Icons.payment,
                  label: 'Billing',
                  isSelected: false,
                ),
                _buildMenuItem(
                  icon: Icons.add_circle_outline,
                  label: 'Create new event',
                  isSelected: false,
                ),
                const SizedBox(height: 32),
                Text(
                  'ACCOUNT PAGES',
                  style: AppTextStyles.hindTextTheme(fontSize: 12)
                      .copyWith(color: AppPalette.darkHint),
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  icon: Icons.person,
                  label: 'Profile',
                  isSelected: false,
                ),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Navigation Bar
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
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
                      IconButton(
                        icon: const Icon(Icons.search, color: AppPalette.darkText),
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
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: isSelected ? AppPalette.primaryGradient : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppPalette.darkText : AppPalette.darkHint,
        ),
        title: Text(
          label,
          style: AppTextStyles.primaryTextTheme().copyWith(
            color: isSelected ? AppPalette.darkText : AppPalette.darkHint,
          ),
        ),
        onTap: () {},
        selected: isSelected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
