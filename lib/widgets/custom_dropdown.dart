import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.value,
      required this.onSelect,
      required this.dropDownList});

  final String value;
  final void Function(String?) onSelect;
  final List<DropdownMenuItem<String>>? dropDownList;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white, //background color of dropdown button
        border: Border.all(
            color: const Color(0xFF5645FF),
            width: 1), //border of dropdown button
        borderRadius:
            BorderRadius.circular(8), //border raiuds of dropdown button
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: DropdownButton(
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black54,
          ),
          value: value,
          items: dropDownList,
          onChanged: onSelect, //Icon color
          style: GoogleFonts.poppins(
            //te
            color: const Color(0xff292929), //Font color
            fontSize: 14,
            fontWeight: FontWeight.w600, //font size on dropdown button
          ),
          dropdownColor: const Color(
            0xfff4f4f4,
          ), //dropdown background color
          underline: Container(), //remove underline
          isExpanded: true, //make true to make width 100%
        ),
      ),
    );
  }
}
