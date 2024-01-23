import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/vacancy_model.dart';
import 'package:harapanti/provider/vacancy_provider.dart';
import 'package:harapanti/ui/personal/vacancy_detail.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/vacancy_item.dart';

class VacancyList extends ConsumerWidget {
  const VacancyList({
    super.key,
    required this.listJobType,
    required this.listRangeType,
    required this.setPageNumber,
  });

  final List<String> listJobType;
  final List<String> listRangeType;
  final void Function(int) setPageNumber;
  void _selectJob(Vacancy vacancyData, BuildContext context) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => VacancyDetailPage(vacancyData: vacancyData),
      ),
    );
    if (response != null) setPageNumber(response);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Vacancy>> vacancyData =
        ref.watch(ListVacancyByFilterProvider(listJobType, listRangeType));

    return switch (vacancyData) {
      AsyncData(:final value) => value.isEmpty
          ? const Expanded(
              child: ErrorPage(msg: 'Belum ada lowongan', color: Colors.black))
          : Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return VacancyItem(
                    vacancyData: value[index],
                    onSelectJob: _selectJob,
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
