import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/splash/splash_screen.dart';

void main() {
  runApp(const StudySyncApp());
}

class StudySyncApp extends StatelessWidget {
  const StudySyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Sync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppEntry(),
    );
  }
}

/// Decides where the app should start:
/// - First launch (onboarding not seen yet) -> SplashScreen -> Onboarding flow
/// - Returning user (already onboarded) -> straight to LoginScreen
///   (swap this for HomeDashboard later once you check for a saved auth token)
class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  bool? _hasSeenOnboarding;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('has_seen_onboarding') ?? false;
    if (!mounted) return;
    setState(() => _hasSeenOnboarding = seen);
  }

  @override
  Widget build(BuildContext context) {
    // Still checking shared_preferences — show a blank/loading frame briefly.
    if (_hasSeenOnboarding == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF4A4390),
        body: SizedBox.shrink(),
      );
    }

    // First-time user: run splash -> onboarding -> notifications -> login.
    if (!_hasSeenOnboarding!) {
      return const SplashScreen();
    }

    // Returning user: skip onboarding entirely.
    return const LoginScreen();
  }
}