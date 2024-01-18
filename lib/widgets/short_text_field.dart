import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ShortTextField extends StatelessWidget {
  ShortTextField({
    super.key,
    required this.controller,
    required this.tipeInput,
    this.thickness,
  });

  final TextEditingController controller;
  final TextInputType tipeInput;
  double? thickness;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      keyboardType: tipeInput,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF8A61FF),
            width: thickness ?? 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 68, 54, 161),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        // hintStyle: GoogleFonts.poppins(color: Colors.black26, fontSize: 16),
      ),
    );
  }
}
