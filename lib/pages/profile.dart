// profile.dart
import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/pages/home.dart';
import 'package:ar_navigation/pages/logout.dart';
import 'package:ar_navigation/utilities/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
            )),
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
                        MaterialPageRoute(builder: (context) => const Home()));
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
                      color: MyColors.primaryColorBg,
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(children: [
                  const CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                          radius: 50.0, child: Icon(Icons.person))),
                  Center(
                    child: Column(
                      children: [
                        Text(' $firstName',
                            style: TextStyle(
                                fontSize: 24, color: MyColors.primaryColor)),
                        Text(email,
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
                        const SizedBox(width: 5.0),
                        const Text(
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
      },
    );
  }
}
