import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/application_model.dart';
import 'package:harapanti/provider/application_provider.dart';
import 'package:harapanti/widgets/applicant.dart';
import 'package:harapanti/widgets/error_page.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenVacancyDetailPage extends ConsumerWidget {
  const OpenVacancyDetailPage({super.key, required this.vacancyID});

  final String vacancyID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Application>> appData =
        ref.watch(ApplicationDataProvider(vacancyID));

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customNavBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
            child: switch (appData) {
          AsyncData(:final value) => value.isEmpty
              ? getWidget(
                  const ErrorPage(
                      msg: 'Belum ada pelamar', color: Colors.black),
                  context)
              : ApplicantWidget(appData: value),
          AsyncError() => getWidget(
              const ErrorPage(msg: 'Something went wrong', color: Colors.black),
              context),
          _ => getWidget(const LoadingPage(), context),
        }),
      ),
    );
  }

  Widget getWidget(Widget widget, BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 31, left: 7, right: 7, bottom: 31),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.navigate_before,
                  color: Color(0xFF8A61FF),
                  size: 50,
                ),
              ),
              Text(
                'Informasi Pelamar',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF5645FF),
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
        widget
      ],
    );
  }

  Container customNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.work_rounded,
              barLabel: "Lowongan",
              isBarSelected: true,
              lineWidth: 70,
            ),
            onTap: () {
              Navigator.pop(context, 0);
            },
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.home_work_outlined,
              barLabel: "Data Panti",
              isBarSelected: false,
            ),
            onTap: () {
              Navigator.pop(context, 1);
            },
          ),
          InkWell(
            child: SelectedNavigationBarItem(
              barIcon: Icons.handshake_outlined,
              barLabel: "Donasi",
              isBarSelected: false,
            ),
            onTap: () {
              Navigator.pop(context, 2);
            },
          ),
        ],
      ),
    );
  }
}
