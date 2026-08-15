import 'dart:async';
import 'package:flutter/material.dart';
import '../../../services/session_service.dart';
import 'session_complete_screen.dart';

class ActiveSessionScreen extends StatefulWidget {
  final int sessionId;
  final int totalMinutes;
  final String subjectName;

  const ActiveSessionScreen({
    super.key,
    required this.sessionId,
    required this.totalMinutes,
    required this.subjectName,
  });

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late int _secondsRemaining;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.totalMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;
      if (_secondsRemaining <= 0) {
        timer.cancel();
        _completeSession();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  Future<void> _completeSession() async {
    await SessionService.endSession(widget.sessionId, widget.totalMinutes);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SessionCompleteScreen(
            subjectName: widget.subjectName,
            durationMinutes: widget.totalMinutes,
          ),
        ),
      );
    }
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B4FE9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.subjectName,
                  style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 24),
              Text(
                _formattedTime,
                style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _isPaused = !_isPaused),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5B4FE9),
                    ),
                    child: Text(_isPaused ? "Resume" : "Pause"),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      _timer?.cancel();
                      _completeSession();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("End Session"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
