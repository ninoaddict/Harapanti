import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:harapanti/models/panti_model.dart';

class PantiItem extends StatelessWidget {
  const PantiItem({
    super.key,
    required this.pantiItemData,
    required this.onSelect,
  });

  final Panti pantiItemData;
  final void Function(BuildContext, Panti) onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect(context, pantiItemData);
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
                      pantiItemData.imageUrl!,
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
                    pantiItemData.pantiName,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    StringFormattingHelper.trimAndCapitalizeWords(
                        pantiItemData.city),
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    pantiItemData.description,
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
