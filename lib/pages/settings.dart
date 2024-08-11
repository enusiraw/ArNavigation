import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: MyColors.tertiaryColor, 
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Account Settings'),
          _buildListTile(
            icon: Icons.person,
            title: 'Profile Information',
            onTap: () {
              // Navigate to Profile Information page
            },
          ),
          _buildListTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {
              // Navigate to Change Password page
            },
          ),
          _buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              // Handle logout action
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('App Preferences'),
          _buildListTile(
            icon: Icons.light_mode,
            title: 'Theme',
            onTap: () {
              // Navigate to Theme Settings page
            },
          ),
          _buildListTile(
            icon: Icons.language,
            title: 'Language',
            onTap: () {
              // Navigate to Language Settings page
            },
          ),
          _buildListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              // Navigate to Notification Settings page
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Privacy and Security'),
          _buildListTile(
            icon: Icons.security,
            title: 'Privacy Policy',
            onTap: () {
              // Open Privacy Policy
            },
          ),
          _buildListTile(
            icon: Icons.data_usage,
            title: 'Data Management',
            onTap: () {
              // Navigate to Data Management page
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('About the App'),
          _buildListTile(
            icon: Icons.info,
            title: 'About This App',
            onTap: () {
              // Navigate to About page
            },
          ),
          _buildListTile(
            icon: Icons.feedback,
            title: 'Feedback',
            onTap: () {
              // Navigate to Feedback page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyColors.primaryColor, 
      ),
    );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon,
          color: MyColors.primaryColor), 
      title: Text(title),
      onTap: onTap,
    );
  }
}
