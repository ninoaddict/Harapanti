import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/provider/user_provider.dart';
import 'package:harapanti/ui/organization/adminhome.dart';
import 'package:harapanti/ui/personal/home.dart';

class IntermedietePage extends ConsumerWidget {
  const IntermedietePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    final AsyncValue<bool> isAdminData = ref.watch(IsAdminProvider(userID));

    return switch (isAdminData) {
      AsyncData(:final value) =>
        value ? const AdminHomePage() : const HomePage(),
      AsyncError() => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text(
              'Unexpected Error Occured!',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
      _ => const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
    };
  }
}
