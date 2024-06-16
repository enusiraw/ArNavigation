import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';



class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final introKey = GlobalKey<IntroductionScreenState>();
  

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = const PageDecoration(
      titleTextStyle:
          TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
       // controlsMargin: EdgeInsets.all(25.0),
        key: introKey,
        allowImplicitScrolling: true,
        pages: [
          PageViewModel(
            title: "Welcome",
            body: "Get lost? Not anymore! Find your way with ease using augmented reality.",
          image: Container(
              margin:  EdgeInsets.only( top: 35.h),
              child: Lottie.asset(
                'assets/animations/lost.json', // Replace with the path to your Lottie animation file
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Stay Connected",
            body: "Navigate unfamiliar buildings with confidence. Our AR app makes it simple and intuitive.",
            image: Lottie.asset('assets/animations/page1.json'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Get Started",
            body: "Effortlessly find what you're looking for with our AR-powered indoor navigation app. Save time and frustration.!",
            image: Lottie.asset('assets/animations/page3.json'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: getDotDecoration(),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Home()),
    );
  }

  PageDecoration getPageDecoration() {
    const bodyStyle = TextStyle(fontSize: 19.0);
    return const PageDecoration(
      titleTextStyle:
          TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor:Colors.white,
      imagePadding: EdgeInsets.zero,
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


