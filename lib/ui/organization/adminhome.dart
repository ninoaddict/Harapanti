import 'package:flutter/material.dart';
import 'package:harapanti/ui/construction.dart';
import 'package:harapanti/ui/organization/edit_panti.dart';
import 'package:harapanti/ui/organization/new_vacancy.dart';
import 'package:harapanti/ui/organization/openvacancy.dart';
import 'package:harapanti/widgets/navigation_bar_item.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() {
    return _AdminHomePageState();
  }
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedPageIndex = 0;

  late List<Widget> _screenList;

  void _addNewVacancy() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewVacancyPage()));
  }

  late List<Widget?> _fabList;
  void onSelectPage(int index) {
    if (mounted) {
      setState(() {
        _selectedPageIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _screenList = [
      OpenVacancyPage(
        onSelectPage: onSelectPage,
      ),
      const EditPantiPage(),
      const ConstructionPage()
    ];

    _fabList = [
      SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF5645FF),
          onPressed: _addNewVacancy,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ),
      null,
      null
    ];
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
                    barLabel: "Lowongan",
                    isBarSelected: true,
                    lineWidth: 70,
                  )
                : SelectedNavigationBarItem(
                    barIcon: Icons.work_outline_outlined,
                    barLabel: "Lowongan",
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
                    barLabel: "Data Panti",
                    isBarSelected: true,
                    lineWidth: 85,
                  )
                : SelectedNavigationBarItem(
                    barIcon: Icons.home_work_outlined,
                    barLabel: "Data Panti",
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
                    barLabel: "Buka Donasi",
                    isBarSelected: true,
                    lineWidth: 85,
                  )
                : SelectedNavigationBarItem(
                    barIcon: Icons.handshake_outlined,
                    barLabel: "Buka Donasi",
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: _fabList[_selectedPageIndex],
      ),
      body: _screenList[_selectedPageIndex],
      // body: IndexedStack(
      //   index: _selectedPageIndex,
      //   children: _screenList,
      // ),
    );
  }
}
