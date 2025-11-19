

import 'package:flutter/material.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/modules/auth/pages/forgot_pass_screen.dart';
import 'package:movies/modules/auth/pages/login_screen.dart';
import 'package:movies/modules/auth/pages/register_screen.dart';

import '../../modules/onboarding/pages/intro_screen.dart';
import '../../modules/onboarding/pages/onboarding_screen.dart';
import '../../modules/splash/pages/splash_screen.dart';

class AppRoutes {


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteNames.intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteNames.forgot:
        return MaterialPageRoute(builder: (_) => const ForgotPassScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}