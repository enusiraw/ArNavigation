import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  final String roomrsicon;
  final VoidCallback onTap; // Correctly define the onTap parameter

  const Rooms({super.key, required this.roomrsicon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the onTap callback
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.tertiaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            roomrsicon,
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}
