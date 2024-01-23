import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/application_model.dart';
import 'package:harapanti/widgets/applicant_card.dart';

class ApplicantWidget extends StatefulWidget {
  const ApplicantWidget({super.key, required this.appData});

  final List<Application> appData;

  @override
  State<StatefulWidget> createState() {
    return _ApplicantWidgetState();
  }
}

class _ApplicantWidgetState extends State<ApplicantWidget> {
  int _selectedPage = 0;
  int _firstPage = 0;
  late int _lastPage;
  late List<int> _pageNumberList;

  @override
  void initState() {
    super.initState();
    _lastPage = min(3, widget.appData.length - 1);

    _pageNumberList =
        List<int>.generate(widget.appData.length, (index) => index + 1);
  }

  void _setPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void _decrementPageNumber() {
    setState(() {
      if (_selectedPage < _firstPage) {
        _firstPage = _firstPage - 1;
        _lastPage = _lastPage - 1;
      }
    });
  }

  void _incrementPageNumber() {
    setState(() {
      if (_selectedPage > _lastPage) {
        _lastPage = _lastPage + 1;
        _firstPage = _firstPage + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 31, left: 7, right: 7, bottom: 31),
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
              Text(
                'Informasi Pelamar',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF5645FF),
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
        ApplicantCard(appData: widget.appData[_selectedPage]),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: _decrementPageNumber,
              icon: const Icon(
                Icons.arrow_circle_left_rounded,
                color: Color(0xFF5645FF),
                size: 55,
              ),
              padding: EdgeInsets.zero,
            ),
            ..._pageNumberList.sublist(_firstPage, _lastPage + 1).map(
              (e) {
                if (_selectedPage == e - 1) {
                  return Container(
                    alignment: Alignment.center,
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE08B),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      e.toString(),
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF5645FF),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    _setPage(e - 1);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    child: Text(
                      e.toString(),
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF5645FF),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: _incrementPageNumber,
              icon: const Icon(
                Icons.arrow_circle_right_rounded,
                color: Color(0xFF5645FF),
                size: 55,
              ),
              padding: EdgeInsets.zero,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
