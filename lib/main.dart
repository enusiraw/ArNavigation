import 'package:ar_navigation/pages/home.dart';
import 'package:ar_navigation/pages/welcom_scree.dart';
import 'package:ar_navigation/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFFFBFCFF),
            scaffoldBackgroundColor: const Color(0xFF262b31),
            secondaryHeaderColor: const Color(0xFF151a1d),
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Home(); // Ensure you have a Home widget
              } else {
                return const WelcomeScreen(); // Ensure you have a WelcomeScreen widget
              }
            },
          ),
        );
      },
    );
  }
}
