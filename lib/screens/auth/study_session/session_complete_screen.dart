import 'package:flutter/material.dart';

class SessionCompleteScreen extends StatelessWidget {
  final String subjectName;
  final int durationMinutes;

  const SessionCompleteScreen({
    super.key,
    required this.subjectName,
    required this.durationMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF5B4FE9), size: 80),
              const SizedBox(height: 24),
              const Text("Session Complete!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("$subjectName • $durationMinutes minutes",
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Text("🔥 +$durationMinutes points earned!",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B4FE9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Done", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
