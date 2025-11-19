import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/modules/splash/pages/splash_screen.dart'; // Assuming this shows a loading state

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  // Helper method to check the onboarding flag from local storage
  Future<bool> _hasSeenOnboarding() async {
    try {
      final SharedPreferences? prefs = await SharedPreferences.getInstance();
      // Use the safe navigation operator and default to false
      return prefs?.getBool('hasSeenOnboarding') ?? false;
    } catch (e) {
      // If SharedPreferences fails to initialize (as happened before),
      // safely default to true to skip onboarding and prevent crash.
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listens to the user's authentication state saved by Firebase (Persistence Check)
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // --- 1. Loading / Waiting State ---
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show the Splash Screen while waiting for Firebase/App initialization
          return const SplashScreen();
        }

        // --- 2. LOGGED IN ---
        if (snapshot.hasData && snapshot.data != null) {
          // User session found (persistence worked). Go to main flow.
          return Navigator(
            onGenerateRoute: (settings) => settings.name == RouteNames.splash
                ? null // Allow the app to start on the splash/home screen
                : null, // Fallback (This Navigator usually handles the initial route)
            initialRoute: RouteNames.splash,
          );
        }

        // --- 3. NOT LOGGED IN (Check Onboarding Flag) ---
        else {
          return FutureBuilder<bool>(
            future: _hasSeenOnboarding(),
            builder: (context, onboardingSnapshot) {

              if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen(); // Show splash while checking flag
              }

              final bool hasSeenOnboarding = onboardingSnapshot.data ?? true;

              String initialRoute;
              if (hasSeenOnboarding) {
                // If seen onboarding, but not logged in, go to the login page.
                initialRoute = RouteNames.login;
              } else {
                // If NOT seen onboarding, go to the onboarding screens.
                initialRoute = RouteNames.onboarding;
              }

              // Use an internal Navigator to start the app on the correct screen
              return Navigator(
                onGenerateRoute: (settings) => settings.name == initialRoute
                    ? null
                    : null,
                initialRoute: initialRoute,
              );
            },
          );
        }
      },
    );
  }
}