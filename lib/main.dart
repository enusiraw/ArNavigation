import 'package:ar_navigation/pages/about.dart';
import 'package:ar_navigation/pages/home.dart';
import 'package:ar_navigation/pages/login.dart';
import 'package:ar_navigation/pages/settings.dart';
import 'package:ar_navigation/pages/signup.dart';
import 'package:ar_navigation/pages/welcom.dart';
import 'package:ar_navigation/services/location_service.dart';
import 'package:ar_navigation/theme/theme.dart';
import 'package:ar_navigation/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LocationService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.themeMode,
              routes: {
                '/home': (context) => const Home(),
                '/signin': (context) => const SignUpScreen(),
                '/login': (context) => const LoginScreen(),
                '/about': (context) => const AboutPage(),
                '/settings': (context) => const SettingsPage(),
                '/contact': (context) => const LoginScreen(),
                // '/map': (context) => MapView(),
              },
              home: FutureBuilder<String>(
                future: _getInitialScreen(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data == 'welcome') {
                    return const Welcome();
                  } else if (snapshot.data == 'home') {
                    return const Home();
                  } else {
                    return const SignUpScreen();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<String> _getInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      return 'welcome';
    }

    User? user = FirebaseAuth.instance.currentUser;

    return user != null ? 'home' : 'authChecker';
  }
}
