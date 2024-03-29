import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/provider/vacancy_provider.dart';
import 'package:harapanti/widgets/custom_dropdown.dart';
import 'package:harapanti/widgets/long_text_field.dart';
import 'package:intl/intl.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

final formatter = DateFormat.yMd();

class NewVacancyPage extends ConsumerStatefulWidget {
  const NewVacancyPage({super.key});

  @override
  ConsumerState<NewVacancyPage> createState() {
    return _NewVacancyPageState();
  }
}

class _NewVacancyPageState extends ConsumerState<NewVacancyPage> {
  late TextEditingController _respController;
  late TextEditingController _syaratController;
  String _posisi = 'pekerja_sosial';
  String _rentangWaktu = 'tetap';
  bool _isLoading = false;

  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _respController = TextEditingController();
    _syaratController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customNavBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Tambah Pekerjaan',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF5645FF),
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Posisi/Jabatan',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff292929),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomDropDown(
                      value: _posisi,
                      onSelect: _selectPosisi,
                      dropDownList: const [
                        DropdownMenuItem(
                          value: "pekerja_sosial",
                          child: Text("Pekerja Sosial"),
                        ),
                        DropdownMenuItem(
                          value: "relawan",
                          child: Text("Relawan"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Rentang Waktu',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff292929),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomDropDown(
                      value: _rentangWaktu,
                      onSelect: _selectRentang,
                      dropDownList: const [
                        DropdownMenuItem(
                          value: "tetap",
                          child: Text("Tetap"),
                        ),
                        DropdownMenuItem(
                          value: "sementara",
                          child: Text("Sementara"),
                        ),
                        DropdownMenuItem(
                          value: 'kontrak',
                          child: Text('Kontrak'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Tanggung Jawab',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff292929),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LongTextField(controller: _respController, height: 130),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Persyaratan',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff292929),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LongTextField(controller: _syaratController, height: 130),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Batas Pendaftaran',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff292929),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: _presentDatePicker,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xff8A61FF),
                          ),
                        ),
                        color: Colors.white,
                        shadowColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                _endDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_endDate!),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff292929),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFE08B),
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(double.infinity, 52),
                            ),
                            child: Text(
                              'Unggah Pekerjaan',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF292929),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _respController.dispose();
    _syaratController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();
    final enteredResp = _respController.text;
    final enteredSyarat = _syaratController.text;
    if (enteredResp.isEmpty ||
        enteredResp.trim().isEmpty ||
        enteredSyarat.isEmpty ||
        enteredSyarat.trim().isEmpty ||
        _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
          'Data form tidak valid', Colors.red, Colors.red, Icons.info));
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final pantiResp = await FirebaseFirestore.instance
          .collection('pantiData')
          .where('userID', isEqualTo: user.uid)
          .get();

      final currPantiData = pantiResp.docs[0].data();
      if (currPantiData['pantiName'] == '-' && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Mohon lengkapi data panti Anda!', Colors.red,
              Colors.red, Icons.info),
        );
        Navigator.of(context).pop();
        return;
      }

      final Map<String, dynamic> data = {
        "pantiID": pantiResp.docs[0].id,
        "city": currPantiData['city'],
        'createdAt': DateTime.now(),
        'endDate': _endDate,
        'jobType': _posisi,
        'rangeType': _rentangWaktu,
        'tanggungjawab': enteredResp,
        'syarat': enteredSyarat,
        'status': 'ongoing',
        'numberOfApplicant': 0,
        'pantiName': currPantiData['pantiName'],
        'imageUrl': currPantiData['imageUrl']
      };
      ref.read(vacancyListProvider.notifier).createVacancy(data);

      setState(() {
        _isLoading = false;
      });
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
            'Data form tidak valid', Colors.red, Colors.red, Icons.info));
      }
      setState(() {
        _isLoading = false;
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

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day + 1);
    final lastDate = DateTime(now.year + 5, now.month, now.day);
    final pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(data: ThemeData(), child: child!);
      },
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _endDate = pickedDate;
    });
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
              barLabel: "Lowongan",
              isBarSelected: true,
              lineWidth: 70,
            ),
            onTap: () {
              Navigator.of(context).pop();
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
              barLabel: "Donasi",
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

  void _selectPosisi(String? value) {
    setState(() {
      _posisi = value!;
    });
  }

  void _selectRentang(String? value) {
    setState(() {
      _rentangWaktu = value!;
    });
  }
}
