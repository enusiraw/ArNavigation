import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About This App',
          style: GoogleFonts.josefinSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1C1C1C),
          ),
        ),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Overview', Icons.info),
            _buildSectionContent(
              'This indoor navigation app is designed to help you find your way through [specific building/location] with ease using cutting-edge AR technology.',
            ),
            _buildDivider(),
            _buildSectionTitle('Key Features', Icons.star),
            _buildBulletPoints([
              'AR Navigation: Find your way with visual directions overlaid on your camera view.',
              'POI Search: Easily locate offices, meeting rooms, and other key locations.',
              'Real-Time Updates: Get live location updates and accurate directions.',
            ]),
            _buildDivider(),
            _buildSectionTitle('How to Use', Icons.play_circle_fill),
            _buildBulletPoints([
              'Open the app and grant location access.',
              'Select your current location and desired destination.',
              'Follow the AR directions to reach your destination.',
            ]),
            _buildDivider(),
            _buildSectionTitle('Technologies Used', Icons.settings),
            _buildBulletPoints([
              'Flutter: Cross-platform mobile development.',
              'Unity: AR and 3D model integration.',
              'ARCore: Augmented Reality capabilities.',
              'Firebase: Backend data storage and real-time sync.',
            ]),
            _buildDivider(),
            _buildSectionTitle('About the Developers', Icons.people),
            _buildSectionContent(
              'Developed by [Your Name/Team], passionate about creating innovative navigation solutions.',
            ),
            _buildDivider(),
            _buildSectionTitle('Privacy Policy', Icons.privacy_tip),
            _buildLinkText('View our Privacy Policy', onTap: () {
              // Link to privacy policy
            }),
            _buildDivider(),
            _buildSectionTitle('Contact Us', Icons.contact_mail),
            _buildSectionContent(
              'For support, please contact email@example.com. Follow us on Twitter/LinkedIn for updates.',
            ),
            _buildDivider(),
            _buildSectionTitle('Version', Icons.update),
            _buildSectionContent('App Version: 1.0.0'),
            _buildDivider(),
            _buildSectionTitle('Acknowledgments', Icons.favorite),
            _buildSectionContent(
              'Special thanks to [individuals/libraries] for their contributions.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: MyColors.primaryColor, size: 26),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      child: Text(
        content,
        style: GoogleFonts.josefinSans(fontSize: 14.sp, color: Colors.black87),
      ),
    );
  }

  Widget _buildBulletPoints(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((point) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Icon(Icons.circle, size: 6.sp, color: Colors.black54),
              ),
              Expanded(
                child: Text(
                  point,
                  style: GoogleFonts.josefinSans(
                      fontSize: 14.sp, color: Colors.black87),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Divider(
        color: Colors.black26,
        thickness: 1,
      ),
    );
  }

  Widget _buildLinkText(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
