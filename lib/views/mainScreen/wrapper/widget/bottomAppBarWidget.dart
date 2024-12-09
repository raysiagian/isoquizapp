import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.pageViewController, // Tambahkan controller sebagai parameter
  }) : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageViewController; // Tambahkan PageController

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      currentIndex: selectedIndex,
      elevation: 0,
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.score),
          label: 'Rank',
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      onTap: (index) {
        onItemTapped(index);
        pageViewController.jumpToPage(index); // Langsung menuju halaman yang dipilih
      },
    );
  }
}
