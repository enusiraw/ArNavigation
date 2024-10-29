import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            roomrsicon,
            style: GoogleFonts.josefinSans(
                fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
