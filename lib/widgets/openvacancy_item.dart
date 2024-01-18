import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:harapanti/widgets/vacancy_item.dart';

class OpenVacancyItem extends StatelessWidget {
  const OpenVacancyItem(
      {super.key, required this.vacancyData, required this.vacancyID});

  final Map<String, dynamic> vacancyData;
  final String vacancyID;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white12,
      onTap: () {
        // onSelectJob(vacancyData, vacancyID);
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.only(bottom: 16, left: 0, right: 0),
          color: const Color(0xFFFFE08B),
          shadowColor: Colors.grey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 12, left: 19, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${StringFormattingHelper.trimAndCapitalizeWords(vacancyData['jobType'])} ${StringFormattingHelper.capitalizeWords(vacancyData['rangeType'])}',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  '${vacancyData['startDate']} - ${vacancyData['endDate']}',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'Pendaftar ${vacancyData['numberOfApplicant']}',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Selengkapnya',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5645FF),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}