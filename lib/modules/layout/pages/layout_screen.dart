import 'package:flutter/material.dart';

import '../../../core/theme/app colors/app_colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
     // bottomNavigationBar: BottomNavigationBar(items: []),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/Home (1).png"), fit: BoxFit.cover)
        ),
      ),
    );
  }
}
