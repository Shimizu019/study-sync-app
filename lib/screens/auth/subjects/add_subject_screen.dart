import 'package:flutter/material.dart';
import '../../../services/subject_service.dart';

class AddSubjectScreen extends StatefulWidget {
  final int userId;
  const AddSubjectScreen({super.key, required this.userId});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _instructorController = TextEditingController();
  final _roomController = TextEditingController();
  String _selectedColor = "#5B4FE9";
  bool _isLoading = false;

  final List<String> _colorOptions = ["#5B4FE9", "#22C55E", "#F97316", "#EF4444", "#0EA5E9", "#A855F7"];

  Future<void> _saveSubject() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject name is required.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await SubjectService.createSubject({
      "user_id": widget.userId,
      "subject_name": _nameController.text.trim(),
      "subject_code": _codeController.text.trim(),
      "instructor": _instructorController.text.trim(),
      "color_tag": _selectedColor,
      "room": _roomController.text.trim(),
    });

    setState(() => _isLoading = false);

    if (result["statusCode"] == 201) {
      if (mounted) Navigator.pop(context, true);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["body"]["message"] ?? "Failed to create subject.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("Add Subject"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Subject Name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: "Subject Code",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _instructorController,
              decoration: InputDecoration(
                labelText: "Instructor",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(
                labelText: "Room",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Color", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: _colorOptions.map((hex) {
                final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
                final selected = _selectedColor == hex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = hex),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: color,
                    child: selected ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveSubject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B4FE9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Subject", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
