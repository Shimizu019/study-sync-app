import 'package:flutter/material.dart';
import '../../../services/subject_service.dart';
import '../../../services/session_service.dart';
import 'active_session_screen.dart';

class StartSessionScreen extends StatefulWidget {
  final int userId;
  const StartSessionScreen({super.key, required this.userId});

  @override
  State<StartSessionScreen> createState() => _StartSessionScreenState();
}

class _StartSessionScreenState extends State<StartSessionScreen> {
  List<dynamic> _subjects = [];
  int? _selectedSubjectId;
  int _selectedMinutes = 25;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final result = await SubjectService.getSubjects(widget.userId);
    if (result["statusCode"] == 200) {
      setState(() => _subjects = result["body"]["subjects"]);
    }
  }

  Future<void> _startSession() async {
    setState(() => _isLoading = true);

    final result = await SessionService.startSession({
      "user_id": widget.userId,
      "subject_id": _selectedSubjectId,
      "task_id": null,
    });

    setState(() => _isLoading = false);

    if (result["statusCode"] == 201) {
      final sessionId = int.parse(result["body"]["session_id"].toString());
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ActiveSessionScreen(
              sessionId: sessionId,
              totalMinutes: _selectedMinutes,
              subjectName: _subjects.firstWhere(
                    (s) => (s["id"] is int ? s["id"] : int.parse(s["id"].toString())) == _selectedSubjectId,
                    orElse: () => {"subject_name": "General Study"},
                  )["subject_name"] ??
                  "General Study",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("Study Session"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: "Subject (optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              value: _selectedSubjectId,
              items: _subjects
                  .map<DropdownMenuItem<int>>((s) => DropdownMenuItem(
                        value: s["id"] is int ? s["id"] : int.parse(s["id"].toString()),
                        child: Text(s["subject_name"]),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedSubjectId = value),
            ),
            const SizedBox(height: 24),
            const Text("Session Length", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [25, 50, 90].map((mins) {
                final selected = _selectedMinutes == mins;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text("$mins min"),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedMinutes = mins),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _startSession,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B4FE9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Start Session", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
