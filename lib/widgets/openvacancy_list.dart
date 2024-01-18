import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/widgets/openvacancy_item.dart';

class OpenVacancyList extends StatefulWidget {
  const OpenVacancyList(
      {super.key, required this.status, required this.pantiId});

  final String status;
  final String pantiId;

  @override
  State<StatefulWidget> createState() {
    return _OpenVacancyListState();
  }
}

class _OpenVacancyListState extends State<OpenVacancyList> {
  late Stream<QuerySnapshot> _vacancyStream;

  @override
  void initState() {
    super.initState();

    if (widget.status == 'all') {
      _vacancyStream = FirebaseFirestore.instance
          .collection('vacancy')
          .orderBy('createdAt', descending: true)
          .where('pantiID', isEqualTo: widget.pantiId)
          .snapshots();
    } else {
      _vacancyStream = FirebaseFirestore.instance
          .collection('vacancy')
          .orderBy('createdAt', descending: true)
          .where('pantiID', isEqualTo: widget.pantiId)
          .where('status', isEqualTo: widget.status)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _vacancyStream,
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
          final Map<String, dynamic> data = {
            "pantiName": 'Dummy Panti',
            'startDate': '12/01/2024',
            'endDate': '21/01/2024',
            'numberOfApplicant': 5,
            'jobType': 'pekerja_sosial',
            'rangeType': 'tetap',
          };
          return OpenVacancyItem(
              vacancyData: data, vacancyID: 'asdasdasdasdasdasdasdasdas');
          // return Center(
          //   child: Text(
          //     'Belum ada lowongan!',
          //     style: GoogleFonts.poppins(color: Colors.black),
          //   ),
          // );
        }
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              Center(
                child: Text(
                  'Data Found!',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
