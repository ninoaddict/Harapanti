import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/ui/organization/openvacancy_detail.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/openvacancy_item.dart';

class OpenVacancyList extends StatefulWidget {
  const OpenVacancyList(
      {super.key, required this.vacancyStream, required this.onSelectPage});

  final Stream<QuerySnapshot> vacancyStream;
  final void Function(int) onSelectPage;

  @override
  State<StatefulWidget> createState() {
    return _OpenVacancyListState();
  }
}

class _OpenVacancyListState extends State<OpenVacancyList> {
  void _selectJob(BuildContext context, String vacancyID) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => OpenVacancyDetailPage(
          vacancyID: vacancyID,
        ),
      ),
    );
    widget.onSelectPage(response as int);
  }

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
          return const Expanded(
            child: LoadingPage(),
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
                onSelectVacancy: _selectJob,
              );
            },
          ),
        );
      },
    );
  }
}
