import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/auth_text_field.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formState = GlobalKey<FormState>();
  late String _fullName;
  late String _emailAdrress;
  late String _accountType;
  String? _previousImage;
  File? _pickedImage;
  bool _isLoading = true;

  // void getUsername() async {
  //   final user = FirebaseAuth.instance.currentUser!;
  // }

  void getUserData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    _fullName = userData.data()!['username'];
    _emailAdrress = userData.data()!['email'];
    _accountType = userData.data()!['category'];
    _previousImage = userData.data()!['imageUrl'];

    setState(
      () {
        _isLoading = false;
      },
    );
  }

  void _onSubmit() async {
    FocusScope.of(context).unfocus();
    final isValid = _formState.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formState.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser!.uid;

      if (_pickedImage == null) {
        await FirebaseFirestore.instance.collection('users').doc(user).update(
          {'username': _fullName},
        );
      } else {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('$user.jpg');
        await storageRef.putFile(_pickedImage!);

        final newImageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(user).update(
          {
            'username': _fullName,
            'imageUrl': newImageUrl,
          },
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Unexpected', Colors.red, Colors.red, Icons.info),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxWidth: 150,
    );

    setState(() {
      if (pickedImage == null) {
        _pickedImage = null;
      } else {
        _pickedImage = File(pickedImage.path);
      }
    });
  }

  final Widget _body = const CircularProgressIndicator(
    color: Color(0xFF8A61FF),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    Expanded(
                      child: Row(
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
                            'Profil Pengguna',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF5645FF),
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.exit_to_app),
                      padding: EdgeInsets.zero,
                      color: const Color(0xFF5645FF),
                      iconSize: 35,
                    )
                  ],
                ),
              ),
              _isLoading
                  ? _body
                  : Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Color(0xFF8A61FF),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        shadowColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 24),
                            child: Form(
                              key: _formState,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: _pickImage,
                                          child: ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(
                                                45,
                                              ), // Image radius
                                              child: _pickedImage == null
                                                  ? (_previousImage == null
                                                      ? Image.asset(
                                                          'assets/images/profile.png',
                                                          fit: BoxFit.cover)
                                                      : Image.network(
                                                          _previousImage!,
                                                          fit: BoxFit.cover,
                                                        ))
                                                  : Image(
                                                      image: FileImage(
                                                          _pickedImage!),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xFF8A61FF),
                                            size: 25,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Nama Lengkap',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff292929),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AuthTextField(
                                    obscureText: null,
                                    hintText: null,
                                    tipeInput: TextInputType.name,
                                    initValue: _fullName,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                                      color: const Color(0xff292929),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AuthTextField(
                                    obscureText: null,
                                    hintText: null,
                                    isDisabled: true,
                                    tipeInput: TextInputType.name,
                                    initValue: _emailAdrress,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Tipe Akun',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff292929),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AuthTextField(
                                    obscureText: null,
                                    hintText: null,
                                    tipeInput: TextInputType.name,
                                    initValue: _accountType == 'personal'
                                        ? 'Calon Relawan/Pekerja Sosial'
                                        : 'Pengurus Panti',
                                    isDisabled: true,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Ganti Password',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff292929),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AuthTextField(
                                    obscureText: null,
                                    hintText: null,
                                    tipeInput: TextInputType.name,
                                    isDisabled: true,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Konfirmasi Ulang Password Baru',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff292929),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AuthTextField(
                                    obscureText: null,
                                    hintText: null,
                                    tipeInput: TextInputType.name,
                                    isDisabled: true,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 39,
              ),
              ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE08B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.only(top: 11, bottom: 11),
                    minimumSize: const Size(354, 52)),
                child: Text(
                  'Simpan Perubahan',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff292929),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
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
}
