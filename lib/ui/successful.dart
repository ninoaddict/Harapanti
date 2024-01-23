import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessfulPage extends StatelessWidget {
  const SuccessfulPage({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: 60,
          child: FloatingActionButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            backgroundColor: const Color(0xFFFFE08B),
            child: Text(
              'Kembali ke awal',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xff292929),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 96,
              width: 312,
              alignment: Alignment.center,
              child: Text(
                msg,
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
              Icons.done_outline,
              color: Color(0xFF5645FF),
              size: 93,
            )
          ],
        ),
      ),
    );
  }
}
