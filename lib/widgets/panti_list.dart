import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/provider/panti_provider.dart';
import 'package:harapanti/ui/personal/panti_detail.dart';
import 'package:harapanti/widgets/panti_item.dart';

class PantiList extends ConsumerWidget {
  const PantiList({super.key, required this.city});

  final String city;

  void _selectPanti(BuildContext context, Panti dataPanti) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PantiDetailPage(dataPanti: dataPanti),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Panti>> listPantiData =
        ref.watch(PantiDataProvider(city));

    return switch (listPantiData) {
      AsyncData(:final value) => value.isEmpty
          ? const Text('No Data Found')
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
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator()
    };
  }
}
