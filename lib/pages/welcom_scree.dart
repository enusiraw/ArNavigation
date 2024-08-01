import 'package:ar_navigation/pages/login.dart';
import 'package:ar_navigation/pages/signup.dart';
import 'package:ar_navigation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Divider(
              height: 100,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Image.asset("assets/images/image.png"), //
              ),
            ),
            Text(
              "Welcome",
              style: GoogleFonts.gemunuLibre(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: ButtonWidget(
                  btnText: "login",
                  onPress: () {
                    print('Login button pressed'); // Debug print statement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }),
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: ButtonWidget(
                  btnText: "signup",
                  onPress: () {
                    print('Signup button pressed'); // Debug print statement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
