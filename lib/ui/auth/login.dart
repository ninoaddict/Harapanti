import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/auth_text_field.dart';

final _firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.showRegisterPage});

  final VoidCallback showRegisterPage;

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _loginForm = GlobalKey<FormState>();

  String _enteredEmail = '';
  String _enteredPassword = '';

  bool _isAuthenticating = false;

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
      await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        if (error.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong Password!'),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (error.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Invalid Email!'),
            duration: Duration(seconds: 3),
          ));
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

    if (mounted) {
      setState(() {
        _isAuthenticating = false;
      });
    }
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
                    'Yuk login dulu!',
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
                          return 'Please provide a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 39,
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
                      height: 10,
                    ),
                    Text(
                      'Lupa kata sandi?',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 219,
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
                                'Masuk',
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
                          'Belum punya akun?',
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
