import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/ui/personal/form.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:harapanti/widgets/about_panti.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';
import 'package:harapanti/widgets/number_list_item.dart';

class VacancyDetailPage extends StatelessWidget {
  const VacancyDetailPage(
      {super.key, required this.vacancyData, required this.vacancyID});

  final Map<String, dynamic> vacancyData;
  final String vacancyID;

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
              isBarSelected: true,
              lineWidth: 70,
            ),
            onTap: () {},
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.home_work_outlined,
              barLabel: "Daftar Panti",
              isBarSelected: false,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        height: 52,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => FormPage(
                  vacancyID: vacancyID,
                  pantiID: 'q1231asds123sdsdf' //vacancyData['pantiID'],
                  ,
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFFFFE08B),
          child: Text(
            'Daftar Sekarang',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xff292929),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 31, left: 7, right: 7),
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
                          '${StringFormattingHelper.trimAndCapitalizeWords(vacancyData['jobType'])} ${StringFormattingHelper.capitalizeWords(vacancyData['rangeType'])}',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF5645FF),
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          vacancyData['pantiName'],
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
              const SizedBox(
                height: 31,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tentang Pekerjaan Ini',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Tanggung Jawab',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const NumberListItem(
                        textShown:
                            'Menjadi fasilitator terhadap pendidikan anak-anak panti',
                        textIndex: 1),
                    const NumberListItem(
                        textShown:
                            'Menjadi mediator apabila anak panti asuhan mengalami konflik dengan pihak lain',
                        textIndex: 2),
                    const NumberListItem(
                        textShown:
                            'Menjadi konselor atas permasalahan psikis anak-anak panti',
                        textIndex: 3),
                    const NumberListItem(
                        textShown:
                            'Menjadi perantara antara panti dengan pihak luar khususnya donatur dan pemerintah terkait',
                        textIndex: 3),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Persyaratan',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const NumberListItem(
                        textShown: 'Lulusan S1 Kesejahteraan Sosial ',
                        textIndex: 1),
                    const NumberListItem(
                        textShown: 'IPK minimal 3,2', textIndex: 2),
                    const NumberListItem(
                        textShown: 'Berseda menginap di asrama panti',
                        textIndex: 3),
                    const SizedBox(height: 40),
                    Text(
                      'Tentang Panti',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const AboutPanti(pantiID: 'Q1Nty8IvD7Fik32zVctE'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}