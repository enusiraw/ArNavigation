// lib/profile_information.dart
import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/utilities/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInformationPage extends StatelessWidget {
  const ProfileInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>( 
      future: DBUtils.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No user signed in'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          );
        }

        final user = snapshot.data;
        final email = user?.email ?? '';

        return FutureBuilder<String?>( 
          future: DBUtils.getFirstName(),
          builder: (context, nameSnapshot) {
            if (nameSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final firstName = nameSnapshot.data ?? '';

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Profile Information',
                  style: GoogleFonts.lato(color: MyColors.textColorwhite),
                ),
                backgroundColor: MyColors.tertiaryColor,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://example.com/profile_picture.jpg', // Replace with the user's profile picture URL
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Name: $firstName',
                      style: GoogleFonts.lato(fontSize: 18),
                    ),
                    Text(
                      'Email: $email',
                      style: GoogleFonts.lato(fontSize: 18),
                    ),
                    SizedBox(height: 20),

                    Text(
                      'Navigation History',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildNavigationHistoryTile('Location A'),
                    _buildNavigationHistoryTile('Location B'),
                    _buildNavigationHistoryTile('Location C'),
                    SizedBox(height: 20),

                    Text(
                      'Ways to Remember',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildWayToRememberTile('Use landmarks'),
                    _buildWayToRememberTile('Take notes'),
                    _buildWayToRememberTile('Set reminders'),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        // Handle edit action
                      },
                      child: Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        textStyle: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNavigationHistoryTile(String location) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      elevation: 2,
      child: ListTile(
        title: Text(
          location,
          style: GoogleFonts.lato(fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Handle navigation history tap
        },
      ),
    );
  }

  Widget _buildWayToRememberTile(String tip) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      elevation: 2,
      child: ListTile(
        title: Text(
          tip,
          style: GoogleFonts.lato(fontSize: 16),
        ),
        trailing: Icon(Icons.check),
        onTap: () {
          // Handle tip tap
        },
      ),
    );
  }
}
