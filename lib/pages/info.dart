import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';



class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Space Science and Geospatial Institute'), // App bar title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Assuming a back button on the left
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                   
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                    child: Center(
                      
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 500,
                              height: 500,
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Card Title',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'This is a smaller card centered on the page.',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                 Positioned(
                  top: 30,
                  left: 100,
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10), // Adjusted border radius
                    ),
                    child: const Icon(Icons.map, color: Colors.white),
                  ),
                ),
                  Positioned(
                  top: 30,
                  right: 100,
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 3, 66, 118)
                    ),
                    child: const Icon(Icons.info, color: Colors.white), 
                  ),
                ),
              ],
              
            ),
          ],
        ),
      ),
    );
  }
}