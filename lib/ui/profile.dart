import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/auth_text_field.dart';

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

    setState(
      () {
        _isLoading = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
                                  const Center(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('assets/images/dummy.png'),
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
                                    onSaved: (value) {},
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
                onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
