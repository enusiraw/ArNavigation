import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.josefinSans(
        fontSize: 24.0.sp,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: GoogleFonts.josefinSans(
        fontSize: 18.0.sp,
      ),
      bodyPadding: EdgeInsets.symmetric(horizontal: 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        allowImplicitScrolling: true,
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: buildPageContent(
              title: "Welcome",
              description:
                  "Get lost? Not anymore! Find your way with ease using augmented reality.",
              animationPath: 'assets/animations/page2.json',
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: buildPageContent(
              title: "Stay Connected",
              description:
                  "Navigate unfamiliar buildings with confidence. Our AR app makes it simple and intuitive.",
              animationPath: 'assets/animations/page1.json',
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: buildPageContent(
              title: "Get Started",
              description:
                  "Effortlessly find what you're looking for with our AR-powered indoor navigation app. Save time and frustration!",
              animationPath: 'assets/animations/page3.json',
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text('Skip', style: TextStyle(color: MyColors.primaryColorBg)),
        next: Icon(Icons.arrow_forward, color: MyColors.primaryColorBg),
        done: Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: MyColors.primaryColorBg)),
        dotsDecorator: getDotDecoration(),
      ),
    );
  }

  Widget buildPageContent({
    required String title,
    required String description,
    required String animationPath,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 380.h,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Lottie.asset(
              animationPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.josefinSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                description,
                style: GoogleFonts.josefinSans(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void goToHome(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
      color: const Color(0xFFBDBDBD),
      size: const Size(10.0, 10.0),
      activeSize: const Size(22.0, 10.0),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      activeColor: MyColors.primaryColorBg,
    );
  }
}
