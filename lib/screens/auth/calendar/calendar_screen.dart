import 'package:flutter/material.dart';
import '../../../services/calendar_service.dart';

class CalendarScreen extends StatefulWidget {
  final int userId;
  const CalendarScreen({super.key, required this.userId});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<dynamic> _tasks = [];
  List<dynamic> _classes = [];
  bool _isLoading = true;
  String? _loadError;
  DateTime _selectedDate = DateTime.now();

  final List<String> _dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  void initState() {
    super.initState();
    _loadCalendar();
  }

  Future<void> _loadCalendar() async {
    if (mounted) setState(() { _isLoading = true; _loadError = null; });
    try {
      final result = await CalendarService.getCalendarData(widget.userId);
      if (!mounted) return;
      if (result["statusCode"] == 200 && result["body"] is Map) {
        setState(() {
          _tasks = result["body"]["tasks"] is List ? List<dynamic>.from(result["body"]["tasks"]) : [];
          _classes = result["body"]["recurring_classes"] is List ? List<dynamic>.from(result["body"]["recurring_classes"]) : [];
          _isLoading = false;
        });
      } else {
        setState(() { _isLoading = false; _loadError = "We couldn't load your calendar."; });
      }
    } catch (_) {
      if (mounted) setState(() { _isLoading = false; _loadError = "We couldn't load your calendar. Check your connection and try again."; });
    }
  }

  List<dynamic> get _tasksForSelectedDate {
    final dateStr =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
    return _tasks.where((t) => t["due_date"] == dateStr).toList();
  }

  List<dynamic> get _classesForSelectedDate {
    final dayName = _dayNames[_selectedDate.weekday - 1];
    return _classes.where((c) => c["day_of_week"] == dayName).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final itemsForDay = [..._classesForSelectedDate, ..._tasksForSelectedDate];

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text("Calendar"),
        backgroundColor: scheme.surface,
        elevation: 0,
        foregroundColor: scheme.onSurface,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
            : _loadError != null
              ? Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_loadError!, textAlign: TextAlign.center), const SizedBox(height: 12), ElevatedButton(onPressed: _loadCalendar, child: const Text("Try again"))])))
              : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(16)),
                  child: CalendarDatePicker(
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    onDateChanged: (date) => setState(() => _selectedDate = date),
                  ),
                ),
                Expanded(
                  child: itemsForDay.isEmpty
                      ? const Center(
                          child: Text("No tasks or classes today", style: TextStyle(color: Colors.grey)))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: itemsForDay.length,
                          itemBuilder: (context, index) {
                            final item = itemsForDay[index];
                            final isClass = item["type"] == "class";
                            final colorHex = item["color_tag"] ?? "#5B4FE9";
                            final color = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: scheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(12),
                                border: Border(left: BorderSide(color: color, width: 4)),
                              ),
                              child: Row(
                                children: [
                                  Icon(isClass ? Icons.school : Icons.task_alt, color: color, size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item["title"] ?? "", style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface)),
                                        Text(
                                          isClass
                                              ? "${item["start_time"]} - ${item["end_time"]}"
                                              : "Due: ${item["due_time"] ?? "No time set"}",
                                          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
