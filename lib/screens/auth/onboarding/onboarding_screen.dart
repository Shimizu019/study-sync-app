import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_opt_in_screen.dart';

class _OnboardSlide {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;

  const _OnboardSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Total steps in the whole flow, including the notification screen (dot 4).
  static const int kTotalSteps = 4;

  static const Color kBlue = Color(0xFF1E88FF);
  static const Color kLightBlue = Color(0xFF7FCBF5);
  static const Color kGreen = Color(0xFF34C266);
  static const Color kPurple = Color(0xFF5B4FE9);

  final List<_OnboardSlide> _slides = const [
    _OnboardSlide(
      icon: Icons.menu_book_rounded,
      title: 'Sync Your University\nSchedule',
      description: 'Access real-time schedules and course planning seamlessly.',
      buttonText: 'Set Up Profile',
    ),
    _OnboardSlide(
      icon: Icons.apartment_rounded,
      title: 'Search Your Campus\nInstantly',
      description: 'Locate classes, view faculty details, and track room availability in seconds.',
      buttonText: 'Next',
    ),
    _OnboardSlide(
      icon: Icons.notifications_rounded,
      title: 'Never Miss a Study\nSession',
      description: 'Receive immediate alerts like Your study this session starts now. Open your plan.',
      buttonText: 'Next',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NotificationOptInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _buildSlide(_slides[index]),
              ),
            ),
            buildDotIndicator(activeIndex: _currentPage, totalSteps: kTotalSteps),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _slides[_currentPage].buttonText,
                    style: GoogleFonts.itim(fontSize: 17),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(_OnboardSlide slide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDecoratedIcon(icon: slide.icon),
          const SizedBox(height: 48),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.itim(fontSize: 26, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.itim(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

/// Shared decorative icon block (white rounded square + overlapping circles
/// + diamonds) used on every onboarding-style screen, including the
/// notification opt-in screen, to match the Figma design.
Widget buildDecoratedIcon({required IconData icon, Color iconColor = const Color(0xFF1E88FF)}) {
  const Color kBlue = Color(0xFF1E88FF);
  const Color kLightBlue = Color(0xFF7FCBF5);
  const Color kGreen = Color(0xFF34C266);
  const Color kPurple = Color(0xFF5B4FE9);

  return SizedBox(
    width: 220,
    height: 180,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 10,
          top: 20,
          child: _circle(90, kLightBlue),
        ),
        Positioned(
          right: 20,
          bottom: 10,
          child: _circle(70, kBlue),
        ),
        Positioned(
          right: 10,
          top: 30,
          child: _diamond(14, kGreen),
        ),
        Positioned(
          left: 30,
          bottom: 30,
          child: _diamond(12, kPurple),
        ),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 52),
        ),
      ],
    ),
  );
}

Widget _circle(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Widget _diamond(double size, Color color) {
  return Transform.rotate(
    angle: 0.785398,
    child: Container(width: size, height: size, color: color),
  );
}

/// Shared dot indicator so the notification screen can show step 4 of 4.
Widget buildDotIndicator({required int activeIndex, required int totalSteps}) {
  const Color kBlue = Color(0xFF1E88FF);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(totalSteps, (index) {
      final bool isActive = index == activeIndex;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 22 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive ? kBlue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }),
  );
}