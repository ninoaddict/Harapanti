import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantCard extends StatelessWidget {
  ApplicantCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            color: Color(0xFF8A61FF),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/dummy.png'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Nama Lengkap',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 12, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          data['name'],
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Alamat Email',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 12, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          data['email'],
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292929),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Alamat Rumah',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 12, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          data['homeAddress'],
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292929),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Resume',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 55, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'resume.pdf',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292929),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
