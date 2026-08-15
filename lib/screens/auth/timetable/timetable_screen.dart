import 'package:flutter/material.dart';
import '../../../services/timetable_service.dart';
import 'add_class_screen.dart';

class TimetableScreen extends StatefulWidget {
  final int userId;
  const TimetableScreen({super.key, required this.userId});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  List<dynamic> _classes = [];
  bool _isLoading = true;
  final List<String> _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  void initState() {
    super.initState();
    _loadTimetable();
  }

  Future<void> _loadTimetable() async {
    setState(() => _isLoading = true);
    final result = await TimetableService.getTimetable(widget.userId);
    if (result["statusCode"] == 200) {
      setState(() {
        _classes = result["body"]["timetable"];
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteClass(int id) async {
    await TimetableService.deleteClass(id);
    _loadTimetable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("Timetable"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5B4FE9),
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddClassScreen(userId: widget.userId)),
          );
          if (created == true) _loadTimetable();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _classes.isEmpty
              ? const Center(child: Text("No classes scheduled yet.", style: TextStyle(color: Colors.grey)))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: _days.map((day) {
                    final dayClasses = _classes.where((c) => c["day_of_week"] == day).toList();
                    if (dayClasses.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        ...dayClasses.map((c) {
                          final colorHex = c["color_tag"] ?? "#5B4FE9";
                          final color = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(14),
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
                                      Text(c["subject_name"] ?? "", style: const TextStyle(fontWeight: FontWeight.w600)),
                                      Text("${c["start_time"]} - ${c["end_time"]}${c["room"] != null && c["room"].toString().isNotEmpty ? " • ${c["room"]}" : ""}",
                                          style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                  onPressed: () => _deleteClass(
                                    c["id"] is int ? c["id"] : int.parse(c["id"].toString()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  }).toList(),
                ),
    );
  }
}
