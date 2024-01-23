import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/provider/panti_provider.dart';
import 'package:harapanti/widgets/edit_panti_detail.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';

class EditPantiPage extends ConsumerWidget {
  const EditPantiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Panti> dataPanti = ref.watch(
        SinglePantiByUserProvider(FirebaseAuth.instance.currentUser!.uid));

    return switch (dataPanti) {
      AsyncData(:final value) => EditPantiDetail(
          dataPanti: value,
        ),
      AsyncError() =>
        const ErrorPage(msg: 'Unexpected error occured', color: Colors.white),
      _ => const LoadingPage()
    };
  }
}
