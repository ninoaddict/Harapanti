import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harapanti/widgets/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.vacancyID, required this.pantiID});

  final String vacancyID;
  final String pantiID;

  @override
  State<StatefulWidget> createState() {
    return _FormPageState();
  }
}

class _FormPageState extends State<FormPage> {
  File? _pdfFile;
  final _formState = GlobalKey<FormState>();
  String _fullName = '';
  String _emailAddress = '';
  String _homeAddress = '';
  String? _fileName;

  bool _isAuthenticating = false;
  bool _isSubmitted = false;

  void _submit() async {
    FocusScope.of(context).unfocus();
    final isValid = _formState.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (_pdfFile == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
            'No PDF File Uploaded', Colors.red, Colors.red, Icons.info));
        setState(() {
          _isAuthenticating = false;
        });
      }
      return;
    }

    _formState.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      final pantiData = await FirebaseFirestore.instance
          .collection('vacancy')
          .doc(widget.vacancyID)
          .get();

      if (pantiData.data() == null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
            'Failed to fetch data', Colors.red, Colors.red, Icons.info));
        setState(() {
          _isAuthenticating = false;
        });
        return;
      }

      final int currApplicantNumber =
          pantiData.data()!['numberOfApplicant'] + 1;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('applicant_resume')
          .child(widget.vacancyID)
          .child(_fileName!);

      await storageRef.putFile(_pdfFile!);
      final pdfURL = await storageRef.getDownloadURL();
      final Map<String, dynamic> data = {
        'name': _fullName,
        'email': _emailAddress,
        'homeAddress': _homeAddress,
        'vacancyID': widget.vacancyID,
        'pantiID': widget.pantiID,
        'applicantID': user!.uid,
        'createdAt': DateTime.now(),
        'pdfUrl': pdfURL,
      };

      await FirebaseFirestore.instance
          .collection('vacancy')
          .doc(widget.vacancyID)
          .update({'numberOfApplicant': currApplicantNumber});

      await FirebaseFirestore.instance.collection('application').add(data);
      setState(() {
        _isSubmitted = true;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
            'Unexpected Error Occured', Colors.red, Colors.red, Icons.info));
      }
    }

    setState(() {
      _isAuthenticating = false;
    });
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

  final Widget _submittedPage = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 96,
          width: 312,
          alignment: Alignment.center,
          child: Text(
            'Lamaranmu berhasil terkirim!',
            style: GoogleFonts.poppins(
                color: const Color(0xFF5645FF),
                fontSize: 32,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        const Icon(
          Icons.done_outline,
          color: Color(0xFF5645FF),
          size: 93,
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isSubmitted
          ? Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: FloatingActionButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: const Color(0xFFFFE08B),
                  child: Text(
                    'Kembali ke awal',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff292929),
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 52,
                child: FloatingActionButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: _submit,
                  backgroundColor: const Color(0xFFFFE08B),
                  child: Text(
                    'Kirim',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff292929),
                    ),
                  ),
                ),
              ),
            ),
      body: _isSubmitted
          ? _submittedPage
          : SafeArea(
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
                            'Lengkapi Data Lamaran',
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        key: _formState,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Lengkap',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AuthTextField(
                              obscureText: null,
                              hintText: 'John Doe',
                              tipeInput: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please provide a valid full name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _fullName = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Alamat Email',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AuthTextField(
                              obscureText: null,
                              hintText: 'johndoe@gmail.com',
                              tipeInput: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please provide a valid email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailAddress = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Alamat Rumah',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AuthTextField(
                              obscureText: null,
                              hintText: 'Jl. Orchard No. 35',
                              tipeInput: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please provide a valid home address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _homeAddress = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Upload Resume',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: _getPdf,
                              child: Card(
                                margin: const EdgeInsets.only(
                                  bottom: 12,
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color(0xFF8A61FF),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.white,
                                shadowColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                child: SizedBox(
                                  height: 112,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.upload,
                                        color: Color(0xFF8A61FF),
                                        size: 49,
                                      ),
                                      Text(
                                        _fileName ??
                                            'Upload File Resume kesini',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff292929),
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _getPdf() async {
    var uuid = const Uuid();

    String fileName = '${uuid.v4()}.pdf';

    final file = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf'],
        type: FileType.custom);
    if (file == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(
            "Gagal mengunggah pdf", Colors.red, Colors.red, Icons.info));
      }
      return;
    }

    setState(() {
      _fileName = fileName;
      _pdfFile = File(file.files.single.path!);
    });
  }
}
