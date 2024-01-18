import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortTextField extends StatelessWidget {
  const ShortTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF8A61FF),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 68, 54, 161),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.black26, fontSize: 16),
      ),
    );
  }
}
