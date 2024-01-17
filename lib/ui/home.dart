import 'package:flutter/material.dart';
import 'package:harapanti/ui/panti.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/ui/vacancy.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  final _screenList = [
    const VacancyPage(),
    const PantiPage(),
    const VacancyPage(),
  ];

  void onSelectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
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
            child: _selectedPageIndex == 0
                ? SelectedNavigationBarItem(
                    barIcon: Icons.work_rounded,
                    barLabel: "Relawan",
                    isBarSelected: true,
                    lineWidth: 70,
                  )
                : SelectedNavigationBarItem(
                    barIcon: Icons.work_outline_outlined,
                    barLabel: "Relawan",
                    isBarSelected: false,
                  ),
            onTap: () {
              onSelectPage(0);
            },
          ),
          InkWell(
            child: _selectedPageIndex == 1
                ? SelectedNavigationBarItem(
                    barIcon: Icons.home_work_rounded,
                    barLabel: "Daftar Panti",
                    isBarSelected: true,
                    lineWidth: 85,
                  )
                : SelectedNavigationBarItem(
                    barIcon: Icons.home_work_outlined,
                    barLabel: "Daftar Panti",
                    isBarSelected: false,
                  ),
            onTap: () {
              onSelectPage(1);
            },
          ),
          InkWell(
            child: _selectedPageIndex == 2
                ? SelectedNavigationBarItem(
                    barIcon: Icons.handshake_rounded,
                    barLabel: "Donasi",
                    isBarSelected: true,
                    lineWidth: 85,
                  )
                : SelectedNavigationBarItem(
                    barIcon: Icons.handshake_outlined,
                    barLabel: "Donasi",
                    isBarSelected: false,
                  ),
            onTap: () {
              onSelectPage(2);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customNavBar(context),
      body: _screenList[_selectedPageIndex],
    );
  }
}
