// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    super.key,
    required this.obscureText,
    required this.hintText,
    required this.tipeInput,
    required this.validator,
    required this.onSaved,
  });

  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  bool? obscureText;
  final String hintText;
  final TextInputType tipeInput;

  @override
  State<AuthTextField> createState() {
    return _AuthTextFieldState();
  }
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff705DF5),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 68, 54, 161),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.black26, fontSize: 16),
        suffixIcon: widget.obscureText != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText!;
                  });
                },
                icon: Icon(
                  !widget.obscureText!
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              )
            : null,
      ),
      keyboardType: widget.tipeInput,
      style: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
