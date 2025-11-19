import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';
import 'core/services/auth service/auth_checker.dart';
import 'firebase_options.dart';

void main() async {
  // CRITICAL: Must be called before any native plugins (like Firebase) are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the generated configuration file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp establishes the fundamental framework and the router.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      // The 'home' property points to the AuthChecker, which handles
      // dynamic routing (login/onboarding/home) based on user status.
      home: const AuthChecker(),

      // onGenerateRoute defines how the app navigates between screens later
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}