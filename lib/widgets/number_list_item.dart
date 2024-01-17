import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberListItem extends StatelessWidget {
  const NumberListItem(
      {super.key, required this.textShown, required this.textIndex});

  final String textShown;
  final int textIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 18,
          child: Text(
            '${textIndex.toString()}.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Flexible(
          child: Text(
            textShown,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
