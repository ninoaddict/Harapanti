import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/user_model.dart';
import 'package:harapanti/provider/user_provider.dart';
import 'package:harapanti/widgets/profile_detail.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  Widget getWidget(Widget obj, BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 31, left: 7, right: 7, bottom: 31),
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
              ),
            ],
          ),
        ),
        obj
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<UserModel> userData =
        ref.watch(UserInfoProvider(FirebaseAuth.instance.currentUser!.uid));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: switch (userData) {
            AsyncData(:final value) => ProfileDetailPage(userData: value),
            AsyncError() => getWidget(
                const Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.black),
                ),
                context),
            _ => getWidget(const CircularProgressIndicator(), context),
          },
        ),
      ),
    );
  }
}
