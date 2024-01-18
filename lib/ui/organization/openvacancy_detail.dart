import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harapanti/widgets/applicant_card.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenVacancyDetailPage extends StatefulWidget {
  const OpenVacancyDetailPage({super.key, required this.vacancyID});

  final String vacancyID;

  @override
  State<StatefulWidget> createState() {
    return _OpenVacancyDetailPageState();
  }
}

class _OpenVacancyDetailPageState extends State<OpenVacancyDetailPage> {
  bool _isLoading = true;
  bool _isError = false;
  late List<Map<String, dynamic>> _dataLowongan;
  int _selectedPage = 0;
  late int _firstPage;
  late int _lastPage;
  late List<int> _pageNumberList;

  void _getDataLowongan() async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('application')
          .where(
            'vacancyID',
            isEqualTo: widget.vacancyID,
          )
          .orderBy('createdAt', descending: true)
          .get();

      _dataLowongan = response.docs.map((ss) => ss.data()).toList();
      _firstPage = 0;
      _lastPage = min(3, _dataLowongan.length - 1);

      if (_dataLowongan.isNotEmpty) {
        _pageNumberList =
            List<int>.generate(_dataLowongan.length, (index) => index + 1);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
            'Unexpected error occured', Colors.red, Colors.red, Icons.info));
      }
      setState(
        () {
          _isLoading = false;
          _isError = true;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getDataLowongan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customNavBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 31, left: 7, right: 7, bottom: 31),
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
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (_isError)
                      ? const Center(
                          child: Text('Failed to fetch data!'),
                        )
                      : ApplicantCard(data: _dataLowongan[_selectedPage]),
              if (!_isError && !_isLoading)
                const SizedBox(
                  height: 30,
                ),
              if (!_isError && !_isLoading)
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
                )
            ],
          ),
        ),
      ),
    );
  }

  void _setPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void _decrementPageNumber() {
    if (_selectedPage != 0) {
      setState(() {
        _selectedPage = _selectedPage - 1;
        if (_selectedPage < _firstPage) {
          _firstPage = _firstPage - 1;
          _lastPage = _lastPage - 1;
        }
      });
    }
  }

  void _incrementPageNumber() {
    if (_selectedPage < _dataLowongan.length - 1) {
      setState(() {
        _selectedPage = _selectedPage + 1;
        if (_selectedPage > _lastPage) {
          _lastPage = _lastPage + 1;
          _firstPage = _firstPage + 1;
        }
      });
    }
  }

  SnackBar _getSnackBar(
    String message,
    Color color,
    Color borderColor,
    IconData icon,
  ) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.only(left: 9),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(message,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            )
          ],
        ),
      ),
    );
    return snackBar;
  }

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
              barLabel: "Buka Lowongan",
              isBarSelected: true,
              lineWidth: 70,
            ),
            onTap: () {
              Navigator.pop(context, 0);
            },
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.home_work_outlined,
              barLabel: "Data Panti",
              isBarSelected: false,
            ),
            onTap: () {
              Navigator.pop(context, 1);
            },
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.handshake_outlined,
              barLabel: "Buka Donasi",
              isBarSelected: false,
            ),
            onTap: () {
              Navigator.pop(context, 2);
            },
          ),
        ],
      ),
    );
  }
}
