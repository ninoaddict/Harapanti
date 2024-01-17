import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String)? searchQuery;
  final String hintText;

  const SearchField({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: searchQuery,
      controller: searchController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15.5),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          color: const Color(0xff7A7979),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: const Color.fromARGB(
          64,
          170,
          171,
          235,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {},
        ),
      ),
    );
  }
}
