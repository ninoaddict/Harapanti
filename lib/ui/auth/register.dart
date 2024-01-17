import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/auth_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harapanti/models/account_type.dart';

final _firebase = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.showRegisterPage});

  final VoidCallback showRegisterPage;

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final _loginForm = GlobalKey<FormState>();

  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUsername = '';
  AccountType accountType = AccountType.personal;

  bool _isAuthenticating = false;

  void onChangeRadio() {
    setState(() {
      if (accountType == AccountType.personal) {
        accountType = AccountType.organization;
      } else {
        accountType = AccountType.personal;
      }
    });
  }

  void _submit() async {
    final isValid = _loginForm.currentState!.validate();

    if (!isValid) {
      return;
    }

    _loginForm.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'username': _enteredUsername,
        'email': _enteredEmail,
        'category':
            accountType == AccountType.personal ? 'personal' : 'organization'
      });
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        if (error.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email already in use!'),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication failed.'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }

    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 100),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 53),
                  child: Text(
                    'Yuk daftar akun!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Form(
                key: _loginForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Pengguna',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthTextField(
                      obscureText: null,
                      hintText: 'johndoe@gmail.com',
                      tipeInput: TextInputType.emailAddress,
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please provide a valid email adress';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Nama Pengguna',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthTextField(
                      obscureText: null,
                      hintText: 'John Doe',
                      tipeInput: TextInputType.name,
                      onSaved: (value) {
                        _enteredUsername = value!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please provide a valid username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthTextField(
                      obscureText: true,
                      hintText: '********',
                      tipeInput: TextInputType.name,
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Pilihan Akun',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: onChangeRadio,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          accountType == AccountType.organization
                              ? Icon(
                                  Icons.circle,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Pengurus Panti',
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: onChangeRadio,
                      child: Row(
                        children: [
                          accountType == AccountType.personal
                              ? Icon(
                                  Icons.circle,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Calon Relawan/Pekerja Sosial',
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: _isAuthenticating
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 23, bottom: 22),
                                  minimumSize: const Size(double.infinity, 75)),
                              child: Text(
                                'Daftar',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: InkWell(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          'Sudah punya akun?',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
