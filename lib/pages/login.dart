import 'package:ar_navigation/pages/home.dart';
import 'package:ar_navigation/pages/signup.dart';
import 'package:ar_navigation/widgets/text.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/user_services.dart';
import '../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Loading state variable

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    setState(() {
      isLoading = true; 
    });

    UserService userService = UserService();


    UserCredential? userCredential = await userService.loginUser(email, password);
    setState(() {
      isLoading = false; 
    });

    if (userCredential != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      _showErrorDialog("Login failed. Please check your credentials.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: const TextWidget(
            title: "Error",
            txtSize: 25.0,
            txtColor: Colors.white,
          ),
          content: TextWidget(
            title: message,
            txtSize: 20.0,
            txtColor: Colors.white,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const TextWidget(
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
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                child: Image.asset("assets/images/login1.png"),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "Log In",
                    txtSize: 30,
                    txtColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 20),
                  const TextWidget(
                    title: "Email",
                    txtSize: 22,
                    txtColor: Color(0xFF0D0D0D),
                  ),
                  // Customized Email Input Field
                  _buildCustomTextField(
                    controller: emailController,
                    hintText: "Your Email",
                    isObscure: false,
                  ),
                  const SizedBox(height: 10),
                  const TextWidget(
                    title: "Password",
                    txtSize: 22,
                    txtColor: Color(0xFF0D0D0D),
                  ),
                  // Customized Password Input Field
                  _buildCustomTextField(
                    controller: passwordController,
                    hintText: "Your Password",
                    isObscure: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add your "Forgot Password" logic here
                        },
                        child: const TextWidget(
                          title: "Forget Password?",
                          txtSize: 18,
                          txtColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  isLoading 
                    ? const Loading()
                      : _buildCustomButton(
                          text: "Login",
                          onPress: login,
                        ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                        title: "Don't have an account? ",
                        txtSize: 18,
                        txtColor: Color(0xff999a9e),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const TextWidget(
                          title: "Sign Up",
                          txtSize: 18,
                          txtColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Text Field Widget
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff999a9e),
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _buildCustomButton({
    required String text,
    required VoidCallback onPress,
  }) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
