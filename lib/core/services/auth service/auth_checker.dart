import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/modules/layout/pages/layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/modules/splash/pages/splash_screen.dart';
import 'package:movies/modules/auth/pages/login_screen.dart';
import 'package:movies/modules/onboarding/pages/onboarding_screen.dart';
import '../../../modules/layout/pages/home/pages/home_screen.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  Future<bool> _hasSeenOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('hasSeenOnboarding') ?? false;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // --- Loading state ---
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          return Navigator(
            initialRoute: RouteNames.home,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case RouteNames.home:
                  return MaterialPageRoute(builder: (_) => const LayoutScreen());
                default:
                  return MaterialPageRoute(
                    builder: (_) => const Scaffold(
                      body: Center(child: Text("Unknown route")),
                    ),
                  );
              }
            },
          );
        }

        return FutureBuilder<bool>(
          future: _hasSeenOnboarding(),
          builder: (context, onboardingSnapshot) {
            if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            final seen = onboardingSnapshot.data ?? true;

            final initialRoute =
            seen ? RouteNames.login : RouteNames.onboarding;

            return Navigator(
              initialRoute: initialRoute,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case RouteNames.login:
                    return MaterialPageRoute(builder: (_) => const LoginScreen());
                  case RouteNames.onboarding:
                    return MaterialPageRoute(builder: (_) => const OnboardingScreen());
                  default:
                    return MaterialPageRoute(
                      builder: (_) => const Scaffold(
                        body: Center(child: Text("Unknown route")),
                      ),
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
