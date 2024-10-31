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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Container(
                            width: 350,
                            height: 500,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  'Aeronautics and Astronautics',
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.primaryColorBg,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Explore the exciting fields of Aeronautics and Astronautics, where technology meets the skies and beyond.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.josefinSans(fontSize: 16),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Departments:',
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                ..._buildDepartmentList(),
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
                            width: 100,
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.primaryColorBg,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const ImageIcon(
                                    AssetImage("assets/images/footstep.png"),
                                  ),
                                  Text(
                                    "Go",
                                    style: GoogleFonts.josefinSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
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

  List<Widget> _buildDepartmentList() {
    List<String> departments = [
      'Aerodynamics',
      'Propulsion',
      'Avionics',
      'Space Systems',
      'Flight Mechanics',
    ];
    return departments.map((department) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          department,
          style: GoogleFonts.josefinSans(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
  }
}
