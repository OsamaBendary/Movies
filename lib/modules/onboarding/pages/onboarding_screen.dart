import 'package:flutter/material.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/core/widgets/custom_button/custom_button.dart';
import 'package:movies/modules/onboarding/pages/intro_screen.dart';

import '../../../core/theme/app colors/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/0.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Find Your Next\n Favorite Movie Here", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 36,), textAlign: TextAlign.center,),
                  SizedBox(height: 16,),
                  Text("Get access to a huge library of movies\n to suit all tastes. You will surely like it.", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 20,), textAlign: TextAlign.center,),
                  SizedBox(height: 24,),
                  CustomButton(color:  AppColors.yellow, text: "Explore Now", textColor: AppColors.black, onPressed: (){
                        Navigator.pushNamed(context, RouteNames.intro);
                  },)
            ]),
          ),
        ),
      ),
    );
  }
}
