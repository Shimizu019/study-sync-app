import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import '../login_screen.dart';

class NotificationOptInScreen extends StatelessWidget {
  const NotificationOptInScreen({super.key});

  static const Color kBlue = Color(0xFF1E88FF);

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDecoratedIcon(icon: Icons.notifications_rounded),
              const SizedBox(height: 48),
              Text(
                'Never Miss a Study\nSession',
                textAlign: TextAlign.center,
                style: GoogleFonts.itim(fontSize: 26, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Text(
                'Receive immediate alerts like Your study\nsession starts now. Open your plan.',
                textAlign: TextAlign.center,
                style: GoogleFonts.itim(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 40),
              buildDotIndicator(activeIndex: 3, totalSteps: 4),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _finishOnboarding(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text('Allow Notifications', style: GoogleFonts.itim(fontSize: 17)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _finishOnboarding(context),
                child: Text('Skip for now', style: GoogleFonts.itim(color: Colors.grey)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}