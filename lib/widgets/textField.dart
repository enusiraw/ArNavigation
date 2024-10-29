import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTxtField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const InputTxtField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: GoogleFonts.josefinSans(
        color: const Color.fromARGB(255, 17, 17, 17),
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true, // Add fill color
        fillColor: const Color(0xfff3f4f6), // Light gray background
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          color: const Color(0xff888b91),
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded borders
          borderSide: BorderSide.none, // Remove border lines
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0), // Padding for the text field
      ),
    );
  }
}
