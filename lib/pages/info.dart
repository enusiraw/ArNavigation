// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/pages/profile.dart';
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
        backgroundColor: MyColors.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyColors.primaryColorBg,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            icon: Icon(
              Icons.person,
              size: 30.0,
              color: MyColors.primaryColorBg,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 400,
                height: 700,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Row for the two containers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Orange container
                        Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColorBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.map, color: Colors.white),
                        ),
                        // Info container
                        Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 3, 66, 118),
                          ),
                          child: const Icon(Icons.info, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Card Title',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This is a smaller card centered on the page.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
