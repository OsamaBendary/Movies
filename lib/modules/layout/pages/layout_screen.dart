import 'package:flutter/material.dart';
import 'package:movies/modules/layout/pages/browse/pages/browse_screen.dart';
import 'package:movies/modules/layout/pages/home/pages/home_screen.dart';
import 'package:movies/modules/layout/pages/profile/pages/profile_screen.dart';
import 'package:movies/modules/layout/pages/search/pages/search_screan.dart';
import '../../../core/theme/app colors/app_colors.dart';
import '../../../core/widgets/bottomNavBar/bottom_nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
 List<Widget> screens = [
   HomeScreen(),
   SearchScrean(),
   BrowseScreen(),
   ProfileScreen()
 ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: screens[_selectedIndex],
      ),
      // The key area for the floating bar
      bottomNavigationBar: BottomNavBar(onItemTapped: _onItemTapped, selectedIndex: _selectedIndex,),
    );
  }
}
