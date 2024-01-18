import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstructionPage extends StatelessWidget {
  const ConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 96,
            width: 312,
            alignment: Alignment.center,
            child: Text(
              'Page Under Construction',
              style: GoogleFonts.poppins(
                  color: const Color(0xFF5645FF),
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Icon(
            Icons.construction_outlined,
            color: Color(0xFF5645FF),
            size: 93,
          )
        ],
      ),
    );
  }
}
