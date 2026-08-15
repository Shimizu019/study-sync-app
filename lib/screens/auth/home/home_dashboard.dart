import 'package:flutter/material.dart';
import '../../../services/subject_service.dart';
import '../tasks/task_list_screen.dart';
import '../profile/profile_screen.dart';
import '../calendar/calendar_screen.dart';
import '../subjects/subject_list_screen.dart';
import '../study_session/start_session_screen.dart';

class HomeDashboard extends StatefulWidget {
  final String userName;
  final int userId;

  const HomeDashboard({super.key, required this.userName, required this.userId});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  List<dynamic> _subjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    try {
      final result = await SubjectService.getSubjects(widget.userId);
      if (result["statusCode"] == 200) {
        setState(() {
          _subjects = result["body"]["subjects"];
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _goToSubjects() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubjectListScreen(userId: widget.userId)),
    );
    _loadSubjects();
  }

  void _onNavTap(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TaskListScreen(userId: widget.userId)));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen(userId: widget.userId)));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.userId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF5B4FE9),
        icon: const Icon(Icons.timer, color: Colors.white),
        label: const Text("Study", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StartSessionScreen(userId: widget.userId)),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello, ${widget.userName}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Welcome back to Study Sync", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("My Subjects", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  TextButton(
                    onPressed: _goToSubjects,
                    child: const Text("Manage", style: TextStyle(color: Color(0xFF5B4FE9))),
                  ),
                ],
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _subjects.isEmpty
                        ? Center(
                            child: TextButton(
                              onPressed: _goToSubjects,
                              child: const Text("No subjects yet — tap to add one"),
                            ),
                          )
                        : ListView.builder(
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onNavTap,
        selectedItemColor: const Color(0xFF5B4FE9),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
