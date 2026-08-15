import 'package:flutter/material.dart';
import '../../../services/timetable_service.dart';
import '../../../services/subject_service.dart';

class AddClassScreen extends StatefulWidget {
  final int userId;
  const AddClassScreen({super.key, required this.userId});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  int? _selectedSubjectId;
  String _selectedDay = "Mon";
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final _roomController = TextEditingController();
  List<dynamic> _subjects = [];
  bool _isLoading = false;

  final List<String> _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

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

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _startTime = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _endTime = picked);
  }

  String _formatTime(TimeOfDay t) => "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  Future<void> _saveClass() async {
    if (_selectedSubjectId == null || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject, start time, and end time are required.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await TimetableService.createClass({
      "user_id": widget.userId,
      "subject_id": _selectedSubjectId,
      "day_of_week": _selectedDay,
      "start_time": _formatTime(_startTime!),
      "end_time": _formatTime(_endTime!),
      "room": _roomController.text.trim(),
    });

    setState(() => _isLoading = false);

    if (result["statusCode"] == 201) {
      if (mounted) Navigator.pop(context, true);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["body"]["message"] ?? "Failed to add class.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("Add Class"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: "Subject",
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
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Day of Week",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              value: _selectedDay,
              items: _days.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
              onChanged: (value) => setState(() => _selectedDay = value!),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickStartTime,
                    child: Text(_startTime == null ? "Start Time" : _startTime!.format(context)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickEndTime,
                    child: Text(_endTime == null ? "End Time" : _endTime!.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(
                labelText: "Room (optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveClass,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B4FE9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Class", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
