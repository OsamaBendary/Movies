import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/modules/auth/pages/login_screen.dart';

import '../../../core/theme/app colors/app_colors.dart';
import '../../onboarding/pages/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Image.asset("assets/logos/logo.png", scale: 0.7,),)),
            BounceInUp(
                onFinish: (_) {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 800),
                      pageBuilder: (_, __, ___) => const OnboardingScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },

                delay: Duration(milliseconds: 1500),
                duration: Duration(seconds: 1),
                child: Center(child: Image.asset("assets/logos/route.png"))),
          ],
        ),
      ),
    );
  }
}
