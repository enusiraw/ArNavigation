// logout_dialog.dart
import 'package:ar_navigation/pages/login.dart';
import 'package:ar_navigation/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ar_navigation/pages/home.dart'; 

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _logout(context); 
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); 
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()), 
      (route) => false,
    );
  }
}
