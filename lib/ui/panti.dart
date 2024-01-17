// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/panti_list.dart';
import 'package:harapanti/widgets/search_field.dart';
// import 'package:harapanti/widgets/vacancy_list.dart';

class PantiPage extends StatefulWidget {
  const PantiPage({super.key});

  @override
  State<PantiPage> createState() {
    return _PantiPageState();
  }
}

class _PantiPageState extends State<PantiPage> {
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
    return Padding(
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
                    'Kenalan sama panti?',
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Kuy',
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
                onPressed: () {},
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
          // const VacancyList(),
          PantiList(city: _searchText)
        ],
      ),
    );
  }
}
