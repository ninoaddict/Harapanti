import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/vacancy_model.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';

class VacancyItem extends StatelessWidget {
  const VacancyItem({
    super.key,
    required this.vacancyData,
    required this.onSelectJob,
  });

  final Vacancy vacancyData;
  final void Function(Vacancy vacancyData, BuildContext context) onSelectJob;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelectJob(vacancyData, context);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12, top: 0, left: 0, right: 0),
        color: const Color(0xFFFFE08B),
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(top: 13, bottom: 12, left: 16),
          child: Row(
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                    size: const Size.fromRadius(
                      28,
                    ), // Image radius
                    child: Image.network(
                      vacancyData.imageUrl,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${StringFormattingHelper.trimAndCapitalizeWords(vacancyData.jobType)} ${StringFormattingHelper.capitalizeWords(vacancyData.rangeType)}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    vacancyData.pantiName,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    StringFormattingHelper.trimAndCapitalizeWords(
                        vacancyData.city),
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
