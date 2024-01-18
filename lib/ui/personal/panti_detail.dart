import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/ui/personal/form.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:harapanti/widgets/about_panti.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';

class PantiDetailPage extends StatelessWidget {
  const PantiDetailPage({super.key, required this.dataPanti});

  final Panti dataPanti;

  Container customNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.work_rounded,
              barLabel: "Relawan",
              isBarSelected: false,
              lineWidth: 70,
            ),
            onTap: () {},
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.home_work_outlined,
              barLabel: "Daftar Panti",
              isBarSelected: true,
            ),
            onTap: () {},
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.handshake_outlined,
              barLabel: "Donasi",
              isBarSelected: false,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customNavBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 31, bottom: 51, right: 7, left: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.navigate_before,
                        color: Color(0xFF8A61FF),
                        size: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dataPanti.pantiName,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF5645FF),
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          StringFormattingHelper.trimAndCapitalizeWords(
                              dataPanti.city),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF5645FF),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.people_alt,
                          color: Color(0xFF5645FF),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${dataPanti.numberOfResident} Anak Asuh',
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.work,
                          color: Color(0xFF5645FF),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${dataPanti.numberOfAttendant} Pekerja Sosial',
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF5645FF),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${dataPanti.address}, ${StringFormattingHelper.trimAndCapitalizeWords(dataPanti.city)}',
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: Color(0xFF5645FF),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Sejak ${dataPanti.est}',
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Biografi Panti',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5645FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            dataPanti.biography,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Foto-Foto',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5645FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox.fromSize(
                        child: Image.asset(
                          'assets/images/dummy_panti.png',
                          height: 90,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Kontak',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5645FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_phone,
                          color: Color(0xFF5645FF),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          dataPanti.phoneNumber,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
