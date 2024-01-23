import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/provider/panti_provider.dart';
import 'package:harapanti/ui/profile.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/openvacancy_list.dart';

final db = FirebaseFirestore.instance;

class OpenVacancyPage extends ConsumerStatefulWidget {
  const OpenVacancyPage({super.key, required this.onSelectPage});

  final void Function(int) onSelectPage;

  @override
  ConsumerState<OpenVacancyPage> createState() {
    return _OpenVacancyPageState();
  }
}

class _OpenVacancyPageState extends ConsumerState<OpenVacancyPage> {
  String _currStatus = 'all';

  @override
  Widget build(BuildContext context) {
    AsyncValue<Panti> dataPanti = ref.watch(
        SinglePantiByUserProvider(FirebaseAuth.instance.currentUser!.uid));

    return switch (dataPanti) {
      AsyncData(:final value) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daftar lowongan di',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          value.pantiName,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => const ProfilePage()),
                        );
                      },
                      icon: const Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 58,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 148,
                  height: 48,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white, //background color of dropdown button
                      border: Border.all(
                          color: const Color(0xFF5645FF),
                          width: 2), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          8), //border raiuds of dropdown button
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: DropdownButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                        value: _currStatus,
                        items: const [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "all",
                            child: Text("Semua"),
                          ),
                          DropdownMenuItem(
                            value: "ongoing",
                            child: Text("Dibuka"),
                          ),
                          DropdownMenuItem(
                            value: "closed",
                            child: Text("Ditutup"),
                          )
                        ],
                        onChanged: (val) {
                          setState(
                            () {
                              _currStatus = val!;
                            },
                          );
                        }, //Icon color
                        style: GoogleFonts.poppins(
                          //te
                          color: const Color(0xff292929), //Font color
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w600, //font size on dropdown button
                        ),
                        dropdownColor:
                            const Color(0xfff4f4f4), //dropdown background color
                        underline: Container(), //remove underline
                        isExpanded: true, //make true to make width 100%
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OpenVacancyList(
                  onSelectPage: widget.onSelectPage,
                  pantiID: value.pantiID,
                  status: _currStatus,
                ),
              ],
            ),
          ),
        ),
      AsyncError() =>
        const ErrorPage(msg: "Something went wrong!", color: Colors.black),
      _ => const LoadingPage()
    };
  }
}
