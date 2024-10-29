import 'package:ar_navigation/pages/home.dart';
import 'package:ar_navigation/pages/login.dart';
import 'package:ar_navigation/services/google_services.dart';
import 'package:ar_navigation/services/user_services.dart';
import 'package:ar_navigation/utilities/validators.dart';
import 'package:ar_navigation/widgets/loading.dart';
import 'package:ar_navigation/widgets/social_button.dart';
import 'package:ar_navigation/widgets/text.dart';
import 'package:ar_navigation/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _checkIfLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  void register() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    UserService userService = UserService();

    setState(() {
      isLoading = true;
    });

    UserCredential? userCredential =
        await userService.registerUser(name, email, password);
    setState(() {
      isLoading = false;
    });
    if (userCredential != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      _showErrorDialog("Registration failed. Please try again."
          as FirebaseAuthException); // Use a generic error message
    }
  }

  void _showErrorDialog(FirebaseAuthException e) {
    String message = "";
    if (nameController.text.isEmpty &&
        emailController.text.isEmpty &&
        passwordController.text.isEmpty) {
      message = "Please fill in all fields";
    } else if (e.code == 'weak-password') {
      message = "Password provided is too weak";
    } else if (e.code == 'email-already-in-use') {
      message = "Account already exists";
    } else {
      message = "An error occurred. Please try again.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                onPressed: () => Navigator.pop(context),
                child: const TextWidget(
                  title: "Ok",
                  txtSize: 18.0,
                  txtColor: Colors.blue,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: isLoading 
                    ? const Loading() 
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: "Sign Up",
                            txtSize: 32,
                            txtColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 20),
                          _buildInputFields(),
                          const SizedBox(height: 10),
                          _buildSignupButton(),
                          const SizedBox(height: 20),
                          _buildDividerWithText(),
                          const SizedBox(height: 15),
                          _buildGoogleSignupButton(),
                          _buildLoginRedirect(),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          title: "Name",
          txtSize: 18,
          txtColor: Color(0xFF0D0D0D),
        ),
        InputTxtField(
          hintText: "Your Name",
          controller: nameController,
          validator: nameValidator,
          obscureText: false,
        ),
        const SizedBox(height: 15),
        const TextWidget(
          title: "Email",
          txtSize: 18,
          txtColor: Color(0xFF0D0D0D),
        ),
        InputTxtField(
          hintText: "Your Email",
          controller: emailController,
          validator: emailValidator,
          obscureText: false,
        ),
        const SizedBox(height: 15),
        const TextWidget(
          title: "Password",
          txtSize: 18,
          txtColor: Color(0xFF0D0D0D),
        ),
        InputTxtField(
          hintText: "Password",
          controller: passwordController,
          validator: passwordValidator,
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: register,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(
          "Sign Up",
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDividerWithText() {
    return const Row(
      children: [
        Expanded(
          child: Divider(color: Color(0xff999a9e)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextWidget(
            title: "Or sign up with",
            txtSize: 16,
            txtColor: Color(0xff999a9e),
          ),
        ),
        Expanded(
          child: Divider(color: Color(0xff999a9e)),
        ),
      ],
    );
  }

  Widget _buildGoogleSignupButton() {
    return Center(
      child: SocialButtonWidget(
        bgColor: Colors.white,
        imagePath: 'assets/images/Gmail.png',
        onPress: () async {
          await Services.googleSignIn(context);
        },
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: const Text(
        "Already have an account? Log in",
        style: TextStyle(
          fontSize: 16,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
