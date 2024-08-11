import 'package:ar_navigation/pages/home.dart';
import 'package:ar_navigation/pages/login.dart';
import 'package:ar_navigation/pages/signup.dart';
import 'package:ar_navigation/pages/welcom.dart';
import 'package:ar_navigation/services/AuthChecker.dart';
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
                // '/map': (context) => MapView(),

              },

              home: FutureBuilder<bool>(
                future: _checkFirstLaunch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == true) {
                    return const AuthChecker();
                  }
                  return StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const AuthChecker();
                      } else {
                        return const Welcome();
                      }
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstLaunch') ?? true;
  }
}
