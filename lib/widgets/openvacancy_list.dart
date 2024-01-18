import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/openvacancy_item.dart';

class OpenVacancyList extends StatefulWidget {
  const OpenVacancyList({super.key, required this.vacancyStream});

  final Stream<QuerySnapshot> vacancyStream;

  @override
  State<StatefulWidget> createState() {
    return _OpenVacancyListState();
  }
}

class _OpenVacancyListState extends State<OpenVacancyList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.vacancyStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong!',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data?.size == 0) {
          return Center(
            child: Text(
              'Belum ada lowongan!',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              String vacancyID = snapshot.data!.docs[index].id;
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return OpenVacancyItem(
                vacancyData: data,
                vacancyID: vacancyID,
              );
            },
          ),
        );
      },
    );
  }
}
