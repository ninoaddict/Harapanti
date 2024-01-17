import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SelectedNavigationBarItem extends StatelessWidget {
  SelectedNavigationBarItem({
    super.key,
    required this.barIcon,
    required this.barLabel,
    required this.isBarSelected,
    this.lineWidth,
  });

  final IconData barIcon;
  final String barLabel;
  final bool isBarSelected;
  double? lineWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122.222,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          Icon(
            barIcon,
            size: 35,
            color: Theme.of(context).colorScheme.background,
          ),
          Text(
            barLabel,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.background,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          isBarSelected
              ? const SizedBox(
                  height: 5,
                )
              : const SizedBox(height: 12),
          if (isBarSelected)
            Container(
              height: 5.5,
              width: lineWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
