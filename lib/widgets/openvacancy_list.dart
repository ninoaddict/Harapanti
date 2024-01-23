import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/vacancy_model.dart';
import 'package:harapanti/provider/vacancy_provider.dart';
import 'package:harapanti/ui/organization/openvacancy_detail.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/openvacancy_item.dart';

class OpenVacancyList extends ConsumerWidget {
  const OpenVacancyList(
      {super.key,
      required this.pantiID,
      required this.onSelectPage,
      required this.status});

  final void Function(int) onSelectPage;
  final String pantiID;
  final String status;

  void _selectJob(BuildContext context, String vacancyID) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => OpenVacancyDetailPage(
          vacancyID: vacancyID,
        ),
      ),
    );
    if (response != null) onSelectPage(response);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Vacancy>> vacancyData =
        ref.watch(ListVacancyByPantiProvider(status, pantiID));

    return switch (vacancyData) {
      AsyncData(:final value) => value.isEmpty
          ? const Expanded(
              child: ErrorPage(msg: 'Belum ada lowongan', color: Colors.black))
          : Expanded(
              child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return OpenVacancyItem(
                    vacancyData: value[index],
                    onSelectVacancy: _selectJob,
                  );
                },
              ),
            ),
      AsyncError(:final error) => Expanded(
          child: ErrorPage(msg: error.toString(), color: Colors.black),
        ),
      _ => const LoadingPage()
    };
  }
}
