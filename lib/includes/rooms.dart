// ignore_for_file: prefer_const_constructors

import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';


class Rooms extends StatelessWidget {
  final String roomrsicon;
  const Rooms({super.key, required this.roomrsicon, required Function() onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: MyColors.tertiaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12.0),
        child: Center(
            child: Text(roomrsicon,
                style: TextStyle(
                  fontSize: 28,
                ))));
  }
}