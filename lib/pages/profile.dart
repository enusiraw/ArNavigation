// ignore_for_file: prefer_const_constructors

import 'package:ar_navigation/pages/logout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('No user signed in')),
          );
        }
        final user = snapshot.data;
        final email = user?.email ?? '';
        final firstName = getFirstName(email);

        return Scaffold(
                appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              logOut(context);
            },
            icon: Icon(
              Icons.logout,
              size: 30.0,
              color: Colors.black, // Replace with your desired color
            ),
          )
        ],
      ),
          body: Center(
            child: Text(' $firstName!', style: TextStyle(fontSize: 24)),
          ),
        );
      },
    );
  }

  String getFirstName(String email) {
    final localPart = email.split('@')[0];
    final firstName = localPart.split('.')[0]; 
    return capitalizeFirstLetter(firstName);
  }

  String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }
}
