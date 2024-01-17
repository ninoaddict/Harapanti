import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/provider/job_provider.dart';
import 'package:harapanti/widgets/panti_item.dart';

class PantiList extends ConsumerWidget {
  const PantiList({super.key, required this.city});

  final String city;

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
                  return PantiItem(pantiItemData: value[index]);
                },
              ),
            ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator()
    };
  }
}
