import 'package:flutter/material.dart';
import 'package:movies/core/theme/app%20colors/app_colors.dart';
class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;


  BottomNavBar({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0, left: 9.0, right:9.0),
      child: Container(
        height: 89,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
         showSelectedLabels: false,
          selectedItemColor: AppColors.yellow,
          unselectedItemColor: AppColors.white,
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.map, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30), label: ''),
          ],
        ),
      ),
    );
  }
}