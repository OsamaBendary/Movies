import 'package:flutter/material.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/core/theme/app%20colors/app_colors.dart';
import 'package:movies/modules/onboarding/pages/pages_widget/Pages_widget.dart';
import 'package:movies/modules/onboarding/pages/pages_widget/pages.dart' as OnboardingPages;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main_wrapper.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = _pageController.initialPage;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (index >= 0 && index < OnboardingPages.Pages.pages.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage = index);
    }
  }
  void _nextPage() {
    if (_currentPage < OnboardingPages.Pages.pages.length - 1) {
      _goToPage(_currentPage + 1);
    } else {
      _finishOnboarding();
    }
  }

  void _lastPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    } else {
      Navigator.pop(context);
    }
  }

  void _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(MainWrapper.onboardingKey, true);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingPages.Pages> pages = OnboardingPages.Pages.pages;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemCount: pages.length,
        itemBuilder: (context, index) => PagesWidget(
          pageData: pages[index],
          onNextPressed: _nextPage,
          onBackPressed: index > 0 ? _lastPage : null,
        ),
      ),
    );
  }
}