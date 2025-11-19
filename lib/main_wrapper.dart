import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies/core/routes/route_names.dart';

class MainWrapper {

  static const String onboardingKey = 'hasSeenOnboarding';

  static Future<String> getInitialRoute() async {
    try {
      final SharedPreferences? prefs = await SharedPreferences.getInstance();

      final hasSeenOnboarding = prefs?.getBool(onboardingKey) ?? false;

      if (hasSeenOnboarding) {
        return RouteNames.splash;
      } else {
        return RouteNames.onboarding;
      }
    } catch (e) {
      print('SharedPreferences startup error caught: $e');
      return RouteNames.onboarding;
    }


  }
}