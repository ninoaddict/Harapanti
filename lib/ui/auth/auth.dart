import 'package:flutter/material.dart';
import 'package:harapanti/splash.dart';
import 'package:harapanti/ui/auth/login.dart';
import 'package:harapanti/ui/auth/register.dart';
import 'dart:async';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void toggleScreens() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingSplash();
    }

    if (_isLogin) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showRegisterPage: toggleScreens);
    }
  }
}
