import 'package:flutter/material.dart';
import 'package:quiz_iso_app/views/mainScreen/historyPage/pages/historyPage.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/pages/homePage.dart';
import 'package:quiz_iso_app/views/mainScreen/profileScreen/pages/profilePage.dart';
import 'package:quiz_iso_app/views/mainScreen/rankScreen/pages/rankPage.dart';
import 'package:quiz_iso_app/views/mainScreen/wrapper/widget/bottomAppBarWidget.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          HomePage(
            token: 'token',
          ),
          RankPage(),
          HistoryPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageViewController.jumpToPage(index); // Langsung menuju halaman yang dipilih
        },
        pageViewController: pageViewController, // Kirim controller ke BottomAppBarWidget
      ),
    );
  }
}
