import 'package:flutter/material.dart';
import '../../../services/subject_service.dart';
import 'add_subject_screen.dart';
import '../timetable/timetable_screen.dart';

class SubjectListScreen extends StatefulWidget {
  final int userId;
  const SubjectListScreen({super.key, required this.userId});

  @override
  State<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  List<dynamic> _subjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    setState(() => _isLoading = true);
    final result = await SubjectService.getSubjects(widget.userId);
    if (result["statusCode"] == 200) {
      setState(() {
        _subjects = result["body"]["subjects"];
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteSubject(int id) async {
    await SubjectService.deleteSubject(id);
    _loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("My Subjects"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_view_week),
            tooltip: "Timetable",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimetableScreen(userId: widget.userId)),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5B4FE9),
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSubjectScreen(userId: widget.userId)),
          );
          if (created == true) _loadSubjects();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subjects.isEmpty
              ? const Center(child: Text("No subjects yet — add your first class.", style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _subjects.length,
                  itemBuilder: (context, index) {
                    final subject = _subjects[index];
                    final colorHex = subject["color_tag"] ?? "#5B4FE9";
                    final color = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border(left: BorderSide(color: color, width: 4)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subject["subject_name"] ?? "",
                                    style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text(
                                  "${subject["subject_code"] ?? ""} • ${subject["instructor"] ?? ""}",
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                if (subject["room"] != null && subject["room"].toString().isNotEmpty)
                                  Text(subject["room"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () => _deleteSubject(
                              subject["id"] is int ? subject["id"] : int.parse(subject["id"].toString()),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
