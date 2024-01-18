import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/ui/personal/vacancy_detail.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/vacancy_item.dart';

class VacancyList extends StatefulWidget {
  const VacancyList({
    super.key,
    required this.listJobType,
    required this.listRangeType,
    required this.setPageNumber,
  });

  final List<String> listJobType;
  final List<String> listRangeType;
  final void Function(int) setPageNumber;

  @override
  State<StatefulWidget> createState() {
    return _VacancyListState();
  }
}

class _VacancyListState extends State<VacancyList> {
  late Stream<QuerySnapshot> _pantiStream;

  @override
  void initState() {
    super.initState();
    _pantiStream = FirebaseFirestore.instance
        .collection('vacancy')
        .orderBy('createdAt', descending: true)
        .where(Filter.and(Filter('jobType', whereIn: widget.listJobType),
            Filter('rangeType', whereIn: widget.listRangeType)))
        .snapshots();
  }

  void _selectJob(Map<String, dynamic> vacancyData, String vacancyID) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            VacancyDetailPage(vacancyData: vacancyData, vacancyID: vacancyID),
      ),
    );
    widget.setPageNumber(response);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _pantiStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong!');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoadingPage());
        }
        if (snapshot.data?.size == 0) {
          return Center(
            child: Text(
              'Belum ada lowongan!',
              style: GoogleFonts.poppins(),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              String vacancyID = snapshot.data!.docs[index].id;
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return VacancyItem(
                vacancyData: data,
                onSelectJob: _selectJob,
                vacancyID: vacancyID,
              );
            },
          ),
        );
      },
    );
  }
}
