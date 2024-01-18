import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/provider/panti_provider.dart';
import 'package:harapanti/ui/personal/panti_detail.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/panti_item.dart';

class PantiList extends ConsumerWidget {
  const PantiList({super.key, required this.city, required this.setPageNumber});

  final String city;
  final void Function(int) setPageNumber;

  void _selectPanti(BuildContext context, Panti dataPanti) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PantiDetailPage(dataPanti: dataPanti),
      ),
    );
    setPageNumber(response);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Panti>> listPantiData =
        ref.watch(PantiDataProvider(city));

    return switch (listPantiData) {
      AsyncData(:final value) => value.isEmpty
          ? const Expanded(
              child:
                  ErrorPage(msg: 'Belum ada data panti', color: Colors.black),
            )
          : Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return PantiItem(
                    pantiItemData: value[index],
                    onSelect: _selectPanti,
                  );
                },
              ),
            ),
      AsyncError() => const Expanded(
          child: ErrorPage(msg: 'Something went wrong', color: Colors.black),
        ),
      _ => const Expanded(child: LoadingPage())
    };
  }
}
