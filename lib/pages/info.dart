import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/services/camera_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset(
            'assets/animations/navigator.json',
            repeat: true,
            
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.43),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Container(
                            width: 350,
                            height: 500,
                            padding: const EdgeInsets.all(20),
                            child: const Column(
                              children: [
                                SizedBox(
                                    height: 50), 
                                Text(
                                  'Department Information',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'This is a smaller card centered on the page.',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -20,
                          left: 40,
                          child: Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: MyColors.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.my_location,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: -20,
                          right: 50,
                          child: Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.primaryColorBg,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CameraService()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const ImageIcon(
                                    AssetImage("assets/images/footstep.png"),
                                   
                                  ),
                                  Text(
                                    "Go",
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
