import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/theme/app_theme.dart';
import 'widgets/theme/theme_controller.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/splash/splash_screen.dart';

void main() {
  runApp(const StudySyncApp());
}

class StudySyncApp extends StatefulWidget {
  const StudySyncApp({super.key});

  @override
  State<StudySyncApp> createState() => _StudySyncAppState();
}

class _StudySyncAppState extends State<StudySyncApp> {
  @override
  void initState() {
    super.initState();
    StudySyncThemeController.load();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: StudySyncThemeController.mode,
      builder: (context, mode, _) => MaterialApp(
      title: 'StudySync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: mode,
      home: AppEntry(onThemeModeChanged: StudySyncThemeController.setMode, themeMode: mode),
    ));
  }
}

/// Decides where the app should start:
/// - First launch (onboarding not seen yet) -> SplashScreen -> Onboarding flow
/// - Returning user (already onboarded) -> straight to LoginScreen
///   (swap this for HomeDashboard later once you check for a saved auth token)
class AppEntry extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const AppEntry({super.key, required this.themeMode, required this.onThemeModeChanged});

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
    return LoginScreen(themeMode: widget.themeMode, onThemeModeChanged: widget.onThemeModeChanged);
  }
}