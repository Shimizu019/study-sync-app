import 'package:flutter/material.dart';
import '../../../services/task_service.dart';
import '../../../services/subject_service.dart';

class AddTaskScreen extends StatefulWidget {
  final int userId;
  const AddTaskScreen({super.key, required this.userId});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  String _priority = "medium";
  int? _selectedSubjectId;
  List<dynamic> _subjects = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final result = await SubjectService.getSubjects(widget.userId);
    if (result["statusCode"] == 200) {
      setState(() {
        _subjects = result["body"]["subjects"];
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _dueTime = picked);
  }

  Future<void> _saveTask() async {
    if (_titleController.text.trim().isEmpty || _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and due date are required.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final dueDateStr =
        "${_dueDate!.year}-${_dueDate!.month.toString().padLeft(2, '0')}-${_dueDate!.day.toString().padLeft(2, '0')}";
    final dueTimeStr = _dueTime != null
        ? "${_dueTime!.hour.toString().padLeft(2, '0')}:${_dueTime!.minute.toString().padLeft(2, '0')}"
        : null;

    final result = await TaskService.createTask({
      "user_id": widget.userId,
      "subject_id": _selectedSubjectId,
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "due_date": dueDateStr,
      "due_time": dueTimeStr,
      "priority": _priority,
    });

    setState(() => _isLoading = false);

    if (result["statusCode"] == 201) {
      if (mounted) Navigator.pop(context, true);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["body"]["message"] ?? "Failed to create task.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("Add New Task"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Task Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickDate,
                    child: Text(_dueDate == null
                        ? "Pick Due Date"
                        : "${_dueDate!.month}/${_dueDate!.day}/${_dueDate!.year}"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickTime,
                    child: Text(_dueTime == null ? "Pick Time" : _dueTime!.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Priority Level", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: ["low", "medium", "high"].map((p) {
                final selected = _priority == p;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(p.toUpperCase()),
                      selected: selected,
                      onSelected: (_) => setState(() => _priority = p),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B4FE9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Task", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
