import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/user_model.dart';
import 'package:harapanti/provider/user_provider.dart';
import 'package:harapanti/ui/profile.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/search_field.dart';
import 'package:harapanti/widgets/vacancy_list.dart';

final db = FirebaseFirestore.instance;

class VacancyPage extends ConsumerStatefulWidget {
  const VacancyPage({super.key, required this.setPageNumber});

  final void Function(int) setPageNumber;

  @override
  ConsumerState<VacancyPage> createState() {
    return _VacancyPageState();
  }
}

class _VacancyPageState extends ConsumerState<VacancyPage> {
  List<String> listJobType = ['pekerja_sosial', 'relawan'];
  List<String> listRangeType = ['tetap', 'kontrak', 'sementara'];
  List<String> selectedType = [];

  late TextEditingController _searchController;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> userData =
        ref.watch(UserInfoProvider(FirebaseAuth.instance.currentUser!.uid));

    return switch (userData) {
      AsyncData(:final value) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hai ${value.username}',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          'Jadi relawant panti? Sabi!',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
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
                SearchField(
                  searchController: _searchController,
                  searchQuery: (value) {
                    return _searchText = value;
                  },
                  hintText: 'Cari posisi untuk kamu!',
                ),
                const SizedBox(
                  height: 16,
                ),
                VacancyList(
                  listJobType: listJobType,
                  listRangeType: listRangeType,
                  setPageNumber: widget.setPageNumber,
                ),
              ],
            ),
          ),
        ),
      AsyncError() =>
        const ErrorPage(msg: 'Something went wrong', color: Colors.black),
      _ => const LoadingPage()
    };
  }
}
