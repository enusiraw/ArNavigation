import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
        backgroundColor: MyColors.tertiaryColor, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Overview'),
            _buildSectionContent(
              'This indoor navigation app is designed to help you find your way through [specific building/location] with ease using cutting-edge AR technology.'
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Key Features'),
            _buildBulletPoints([
              'AR Navigation: Find your way with visual directions overlaid on your camera view.',
              'POI Search: Easily locate offices, meeting rooms, and other key locations.',
              'Real-Time Updates: Get live location updates and accurate directions.',
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('How to Use'),
            _buildBulletPoints([
              'Open the app and grant location access.',
              'Select your current location and desired destination.',
              'Follow the AR directions to reach your destination.',
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('Technologies Used'),
            _buildBulletPoints([
              'Flutter: Cross-platform mobile development.',
              'Unity: AR and 3D model integration.',
              'ARCore: Augmented Reality capabilities.',
              'Firebase: Backend data storage and real-time sync.',
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('About the Developers'),
            _buildSectionContent(
              'Developed by [Your Name/Team], passionate about creating innovative navigation solutions.'
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Privacy Policy'),
            _buildLinkText('View our Privacy Policy', onTap: () {
            }),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Us'),
            _buildSectionContent('For support, please contact email@example.com. Follow us on Twitter/LinkedIn for updates.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Version'),
            _buildSectionContent('App Version: 1.0.0'),
            const SizedBox(height: 20),
            _buildSectionTitle('Acknowledgments'),
            _buildSectionContent('Special thanks to [individuals/libraries] for their contributions.'),
          ],
        ),
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

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, color: Colors.black),
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
              const Text(
                '• ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLinkText(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
