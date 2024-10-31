import 'package:ar_navigation/utilities/validators.dart';
import 'package:ar_navigation/widgets/text.dart';
import 'package:ar_navigation/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/button_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> forgetPassword() async {
    final String email = emailController.text.trim();

    // Check if email field is empty
    if (email.isEmpty) {
      _showDialog("Error", "Please enter an email address");
      return; // Exit early if email is empty
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: TextWidget(
            title: "Password reset email has been sent!",
            txtSize: 18.0,
            txtColor: Theme.of(context).primaryColor,
          ),
        ),
      );

      // Navigate back to login page
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: TextWidget(
              title: "No user found for that email.",
              txtSize: 18.0,
              txtColor: Theme.of(context).primaryColor,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: TextWidget(
              title: "An error occurred. Please try again later.",
              txtSize: 18.0,
              txtColor: Theme.of(context).primaryColor,
            ),
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            title: title,
            txtSize: 25.0,
            txtColor: Colors.white,
          ),
          content: TextWidget(
            title: content,
            txtSize: 20.0,
            txtColor: Colors.white,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: TextWidget(
                title: "Ok",
                txtSize: 18.0,
                txtColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 3.5,
                child: Image.asset("assets/image.png"),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "Forgot Password",
                    txtSize: 30,
                    txtColor: Theme.of(context).primaryColor,
                  ),
                  const TextWidget(
                    title: "Email",
                    txtSize: 22,
                    txtColor: Color(0xffdddee3),
                  ),
                  InputTxtField(
                    hintText: "Your Email ID",
                    controller: emailController,
                    validator: (value) =>
                        emailValidator!(value) != null ? null : "Please enter a valid email",
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: ButtonWidget(
                      btnText: isLoading ? "Submitting..." : "Submit",
                      onPress: isLoading ? null : forgetPassword,
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const TextWidget(
                        title: "Back to login",
                        txtSize: 18,
                        txtColor: Color(0xff999a9e),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
