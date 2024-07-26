// ignore_for_file: prefer_const_constructors

import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/pages/home.dart';
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
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No user signed in'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Sign In'),
                ),
              ],
            )),
          );
        }
        final user = snapshot.data;
        final email = user?.email ?? '';
        final firstName = getFirstName(email);

        return Scaffold(
          backgroundColor: MyColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: MyColors.backgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: MyColors.primaryColorBg,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  logOut(context);
                },
                icon: Icon(
                  Icons.logout,
                  size: 30.0,
                  color: MyColors
                      .primaryColorBg, // Replace with your desired color
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(children: [
              CircleAvatar(
                  backgroundColor: Colors.white70,
                  minRadius: 60.0,
                  child: CircleAvatar(radius: 50.0, child: Icon(Icons.person))),
              Center(
                child: Column(
                  children: [
                    Text(' $firstName',
                        style: TextStyle(
                            fontSize: 24, color: MyColors.primaryColor)),
                    Text('$email',
                        style: TextStyle(
                            fontSize: 18, color: MyColors.primaryColor)),
                  ],
                ),
              ),
              Divider(
                height: 100,
                color: MyColors.primaryColorBg,
              ),
              IconButton(
                onPressed: () {
                  logOut(context);
                },
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30.0,
                      color: MyColors.primaryColorBg,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              )
            ]),
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
