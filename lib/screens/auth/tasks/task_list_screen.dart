import 'package:flutter/material.dart';
import '../../../services/task_service.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  final int userId;
  const TaskListScreen({super.key, required this.userId});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<dynamic> _tasks = [];
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    if (mounted) setState(() { _isLoading = true; _loadError = null; });
    try {
      final result = await TaskService.getTasks(widget.userId);
      if (!mounted) return;
      if (result["statusCode"] == 200 && result["body"]["tasks"] is List) {
        setState(() { _tasks = List<dynamic>.from(result["body"]["tasks"]); _isLoading = false; });
      } else {
        setState(() { _isLoading = false; _loadError = "We couldn't load your tasks."; });
      }
    } catch (_) {
      if (mounted) setState(() { _isLoading = false; _loadError = "We couldn't load your tasks. Check your connection and try again."; });
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text("Task List"),
        backgroundColor: scheme.surface,
        elevation: 0,
        foregroundColor: scheme.onSurface,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5B4FE9),
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen(userId: widget.userId)),
          );
          if (created == true) _loadTasks();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
            : _loadError != null
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_loadError!, textAlign: TextAlign.center), const SizedBox(height: 12), ElevatedButton(onPressed: _loadTasks, child: const Text("Try again"))]))
              : _tasks.isEmpty
              ? const Center(child: Text("No tasks yet.", style: TextStyle(color: Colors.grey)))
              : RefreshIndicator(
                  onRefresh: _loadTasks,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      final colorHex = task["color_tag"] ?? "#5B4FE9";
                      final subjectColor = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

                      return Container(
                        key: ValueKey('task-card-${task["id"] ?? index}-${(task["title"] ?? "").toString().trim()}'),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: task["status"] == "completed",
                              onChanged: (value) async {
                                await TaskService.updateTask({
                                  "id": task["id"],
                                  "subject_id": task["subject_id"],
                                  "title": task["title"],
                                  "description": task["description"],
                                  "due_date": task["due_date"],
                                  "due_time": task["due_time"],
                                  "priority": task["priority"],
                                  "status": value == true ? "completed" : "pending",
                                });
                                _loadTasks();
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((task["title"] ?? "").toString().trim(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        decoration: task["status"] == "completed"
                                            ? TextDecoration.lineThrough
                                            : null,
                                      )),
                                  if (task["subject_name"] != null)
                                    Text(task["subject_name"],
                                        style: TextStyle(color: subjectColor, fontSize: 12)),
                                    Text("Due: ${task["due_date"]}",
                                      style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _priorityColor(task["priority"] ?? "medium").withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                (task["priority"] ?? "medium").toString().toUpperCase(),
                                style: TextStyle(
                                  color: _priorityColor(task["priority"] ?? "medium"),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
