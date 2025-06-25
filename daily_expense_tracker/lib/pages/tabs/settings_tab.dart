import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SettingsTab extends StatelessWidget {
  final VoidCallback onLogout;

  const SettingsTab({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Customize your expense tracking experience',
            style: TextStyle(
              color: AppColors.softGray,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          _buildSettingsItem(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage expense reminders',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.backup,
            title: 'Backup & Sync',
            subtitle: 'Save your data securely',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.palette,
            title: 'Theme',
            subtitle: 'Customize app appearance',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Change app language',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () {},
          ),
          
          _buildSettingsItem(
            icon: Icons.info,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () {},
          ),
          
          const SizedBox(height: 24),
          
          // Logout Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warmCoral,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.mintGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.emoji_emotions,
                  size: 32,
                  color: AppColors.mintGreen,
                ),
                SizedBox(height: 8),
                Text(
                  'Daily Expenses Tracker',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.charcoal,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Track your expenses with ease',
                  style: TextStyle(
                    color: AppColors.softGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.sandBeige,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: AppColors.charcoal,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.softGray,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.lightGray,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: AppColors.white,
      ),
    );
  }
}
