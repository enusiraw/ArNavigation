import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings_pages/logout.dart';
import 'settings_pages/personal_info.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: Text(
          'Settings',
          style: GoogleFonts.josefinSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1C1C1C),
          ),
        ),
        //backgroundColor: MyColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Account Settings'),
            _buildListTile(
              icon: Icons.person,
              title: 'Profile Information',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileInformationPage()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogoutDialog()),
                );
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1C1C1C),
        ),
      ),
    );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: MyColors.primaryColor),
        title: Text(title, style: GoogleFonts.josefinSans(fontSize: 14.sp)),
        trailing: Icon(Icons.chevron_right,
            color: MyColors.primaryColor), 
      ),
    );
  }
}
