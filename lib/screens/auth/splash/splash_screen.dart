import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  static const Color kBackground = Color(0xFF423B8C);
  static const Color kAccentBlue = Color(0xFF2E9BFF);
  static const Color kLightBlue = Color(0xFF9BD3F0);
  static const Color kButtonPurple = Color(0xFF5B4FE9);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _isLoading
              ? _buildLoadingContent()
              : FadeTransition(
                  opacity: _fadeAnim,
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    child: _buildLogoContent(),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      key: const ValueKey('loading'),
      mainAxisSize: MainAxisSize.min,
      children: [
        _logoIcon(),
        const SizedBox(height: 20),
        _titleText(),
        const SizedBox(height: 56),
        SizedBox(
          width: 90,
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(kAccentBlue),
                  backgroundColor: Color(0x33000000),
                ),
              ),
              Text(
                'LOADING',
                style: GoogleFonts.itim(
                  color: Colors.white,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoContent() {
    return Column(
      key: const ValueKey('logo'),
      mainAxisSize: MainAxisSize.min,
      children: [
        _logoIcon(),
        const SizedBox(height: 20),
        _titleText(),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: kButtonPurple.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SizedBox(
            width: 220,
            child: ElevatedButton(
              onPressed: _goToOnboarding,
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text('Get Started', style: GoogleFonts.itim(fontSize: 17)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleText() {
    return Text(
      'Study Sync',
      style: GoogleFonts.itim(
        color: Colors.white,
        fontSize: 32,
        shadows: [
          Shadow(color: kLightBlue.withOpacity(0.9), blurRadius: 12),
          Shadow(color: kAccentBlue.withOpacity(0.6), blurRadius: 20),
        ],
      ),
    );
  }

  Widget _logoIcon() {
    return SizedBox(
      width: 140,
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Light rays
          Positioned(
            top: 0,
            child: Icon(Icons.wb_sunny_outlined, color: Colors.white.withOpacity(0.7), size: 26),
          ),
          // Bulb
          Positioned(
            top: 14,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: kAccentBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lightbulb, color: Colors.white, size: 24),
            ),
          ),
          // Open book
          Positioned(
            top: 46,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kLightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.menu_book_rounded, color: kAccentBlue, size: 70),
            ),
          ),
        ],
      ),
    );
  }
}