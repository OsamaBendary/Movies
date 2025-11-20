import 'package:flutter/material.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/modules/auth/pages/forgot_pass_screen.dart';
import 'package:movies/modules/auth/pages/login_screen.dart';
import 'package:movies/modules/auth/pages/register_screen.dart';
import 'package:movies/modules/layout/pages/home/pages/home_screen.dart';
import 'package:movies/modules/layout/pages/layout_screen.dart';
import '../../modules/layout/pages/movie details/pages/movie_details_screen.dart';
import '../../modules/onboarding/pages/intro_screen.dart';
import '../../modules/onboarding/pages/onboarding_screen.dart';
import '../../modules/splash/pages/splash_screen.dart';
import '../services/auth service/auth_checker.dart';

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
      case RouteNames.layout:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.movieDetails:
        return MaterialPageRoute(builder: (_) => const MovieDetailsScreen());
      case RouteNames.authChecker:
        return MaterialPageRoute(builder: (_) => const AuthChecker());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}