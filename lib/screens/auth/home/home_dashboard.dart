import 'package:flutter/material.dart';
import '../../../services/subject_service.dart';
import '../../../widgets/theme/app_colors.dart';
import '../calendar/calendar_screen.dart';
import '../profile/profile_screen.dart';
import '../study_session/start_session_screen.dart';
import '../subjects/add_subject_screen.dart';
import '../subjects/subject_list_screen.dart';
import '../tasks/add_task_screen.dart';
import '../tasks/task_list_screen.dart';

class HomeDashboard extends StatefulWidget {
  final String userName;
  final int userId;
  const HomeDashboard({super.key, required this.userName, required this.userId});
  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 0;
  bool _isLoading = true;
  List<dynamic> _subjects = [];
  final _demoSubjects = const [
    {'subject_name': 'Database Systems', 'subject_code': 'ICT 301', 'instructor': 'Dr. Santos', 'color_tag': '#635BDB'},
    {'subject_name': 'Web Development', 'subject_code': 'IT 204', 'instructor': 'Prof. Lim', 'color_tag': '#2388E8'},
    {'subject_name': 'Software Engineering', 'subject_code': 'SE 210', 'instructor': 'Ms. Rivera', 'color_tag': '#16A085'},
  ];

  @override
  void initState() { super.initState(); _loadSubjects(); }

  Future<void> _loadSubjects() async {
    try {
      final result = await SubjectService.getSubjects(widget.userId);
      if (result['statusCode'] == 200 && result['body']['subjects'] is List) _subjects = result['body']['subjects'];
    } catch (_) { _subjects = _demoSubjects; }
    if (_subjects.isEmpty) _subjects = _demoSubjects;
    if (mounted) setState(() => _isLoading = false);
  }

  void _open(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) _open(TaskListScreen(userId: widget.userId));
    if (index == 2) _showAddMenu();
    if (index == 3) _open(CalendarScreen(userId: widget.userId));
    if (index == 4) _open(ProfileScreen(userId: widget.userId));
  }

  void _showAddMenu() => showModalBottomSheet<void>(
    context: context, showDragHandle: true,
    builder: (context) => SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(24, 8, 24, 24), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Align(alignment: Alignment.centerLeft, child: Text('Create something new', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
      const SizedBox(height: 16),
      _actionTile(Icons.check_circle_outline, 'Add task', 'Capture an assignment or deadline', () { Navigator.pop(context); _open(AddTaskScreen(userId: widget.userId)); }),
      _actionTile(Icons.menu_book_outlined, 'Add subject', 'Organize a course and its tasks', () { Navigator.pop(context); _open(AddSubjectScreen(userId: widget.userId)); }),
      _actionTile(Icons.timer_outlined, 'Start study session', 'Focus on what matters next', () { Navigator.pop(context); _open(StartSessionScreen(userId: widget.userId)); }),
    ]))),
  );

  Widget _actionTile(IconData icon, String title, String subtitle, VoidCallback onTap) => ListTile(
    contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: AppColors.primaryBg, foregroundColor: AppColors.primary, child: Icon(icon)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(subtitle), onTap: onTap,
  );

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      backgroundColor: AppColors.softBg,
      body: SafeArea(child: Row(children: [if (wide) _sidebar(), Expanded(child: _content(wide))])),
      bottomNavigationBar: wide ? null : _bottomNav(),
      floatingActionButton: wide ? FloatingActionButton.extended(onPressed: _showAddMenu, icon: const Icon(Icons.add), label: const Text('Create')) : null,
    );
  }

  Widget _sidebar() => Container(width: 240, color: Colors.white, padding: const EdgeInsets.fromLTRB(20, 28, 20, 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _brand(), const SizedBox(height: 42), const Text('WORKSPACE', style: TextStyle(fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w800, color: AppColors.lightTextSecondary)), const SizedBox(height: 12),
    _sideItem(Icons.home_rounded, 'Overview', 0), _sideItem(Icons.check_circle_outline, 'Tasks', 1), _sideItem(Icons.calendar_month_outlined, 'Schedule', 3), _sideItem(Icons.person_outline, 'Profile', 4), const Spacer(),
    Text('Stay in sync, one day at a time.', style: TextStyle(color: AppColors.primary.withOpacity(.7), height: 1.4)),
  ]));

  Widget _sideItem(IconData icon, String label, int index) { final selected = _selectedIndex == index; return Padding(padding: const EdgeInsets.only(bottom: 8), child: ListTile(
    selected: selected, selectedTileColor: AppColors.primaryBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    leading: Icon(icon, color: selected ? AppColors.primary : AppColors.lightTextSecondary),
    title: Text(label, style: TextStyle(fontWeight: selected ? FontWeight.w800 : FontWeight.w600, color: selected ? AppColors.primary : AppColors.lightText)), onTap: () => _onNavTap(index),
  )); }

  Widget _content(bool wide) {
    final sections = <Widget>[
      _header(), const SizedBox(height: 26), _progress(), const SizedBox(height: 24), _stats(), const SizedBox(height: 30),
      if (wide) Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: _tasks()), const SizedBox(width: 24), SizedBox(width: 320, child: _schedule())])
      else ...[_tasks(), const SizedBox(height: 28), _schedule()],
      const SizedBox(height: 28), _subjectSection(),
    ];
    return Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1180), child: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(wide ? 42 : 20, 24, wide ? 42 : 20, 100), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections),
    )));
  }

  Widget _brand() => Row(children: [Container(width: 38, height: 38, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)), child: Image.asset('lib/Component/img/studySync Logo.jpg', fit: BoxFit.cover)), const SizedBox(width: 10), const Text('StudySync', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: AppColors.lightText))]);
  Widget _header() { final now = DateTime.now(); final weekday = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][now.weekday - 1]; return Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Hello, ${widget.userName}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)), const SizedBox(height: 5), const Text("Here's your academic overview for today.", style: TextStyle(color: AppColors.lightTextSecondary)), const SizedBox(height: 7), Text('$weekday, ${now.day} ${_month(now.month)} ${now.year}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary))])), CircleAvatar(radius: 24, backgroundColor: AppColors.primaryBg, child: Text(widget.userName.isEmpty ? 'S' : widget.userName[0].toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 18)))]); }
  String _month(int month) => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][month - 1];

  Widget _progress() => Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(.22), blurRadius: 18, offset: const Offset(0, 8))]), child: Row(children: [Container(width: 54, height: 54, decoration: BoxDecoration(color: Colors.white.withOpacity(.16), shape: BoxShape.circle), child: const Icon(Icons.auto_awesome, color: Colors.white)), const SizedBox(width: 16), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Today's progress", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700)), SizedBox(height: 4), Text('You are on a good rhythm.', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('2 of 5 tasks completed today', style: TextStyle(color: Colors.white70))])), const Text('40%', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900))]));
  Widget _stats() {
    final items = [
      ('Tasks done', '2 / 5', Icons.check_circle_outline, AppColors.success),
      ('Study time', '1h 20m', Icons.timer_outlined, AppColors.info),
      ('Deadlines', '3 soon', Icons.flag_outlined, AppColors.warning),
    ];
    return Row(children: items.map((item) => Expanded(child: Padding(
      padding: EdgeInsets.only(right: item == items.last ? 0 : 10),
      child: Container(padding: const EdgeInsets.all(14), decoration: _card(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(item.$3, color: item.$4, size: 21), const SizedBox(height: 12),
        Text(item.$2, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), const SizedBox(height: 3),
        Text(item.$1, style: const TextStyle(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w600)),
      ])),
    ))).toList());
  }

  Widget _tasks() => _section("Today's tasks", 'View all', () => _open(TaskListScreen(userId: widget.userId)), [_taskRow('Finish database ERD', 'ICT 301', 'Due today', AppColors.warning, true), _taskRow('Read API authentication chapter', 'IT 204', 'Due tomorrow', AppColors.info, false)]);
  Widget _taskRow(String title, String subject, String due, Color color, bool done) => Container(margin: const EdgeInsets.only(top: 10), padding: const EdgeInsets.all(15), decoration: _card(), child: Row(children: [Icon(done ? Icons.check_circle : Icons.radio_button_unchecked, color: done ? AppColors.success : AppColors.lightTextSecondary), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.w800, decoration: done ? TextDecoration.lineThrough : null)), const SizedBox(height: 5), Text('$subject  •  $due', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w700))])), const Icon(Icons.more_horiz, color: AppColors.lightTextSecondary)]));
  Widget _schedule() => _section('Next on your schedule', 'Open schedule', () => _open(CalendarScreen(userId: widget.userId)), [_scheduleRow('09:00', 'Database Systems', 'Room 204', AppColors.primary), _scheduleRow('13:30', 'Web Development', 'Lab 3', AppColors.info)]);
  Widget _scheduleRow(String time, String title, String room, Color color) => Container(margin: const EdgeInsets.only(top: 10), padding: const EdgeInsets.all(14), decoration: _card(), child: Row(children: [Container(width: 4, height: 45, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(time, style: TextStyle(color: color, fontWeight: FontWeight.w900)), const SizedBox(height: 4), Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), Text(room, style: const TextStyle(fontSize: 12, color: AppColors.lightTextSecondary))])]));

  Widget _subjectSection() => _section('My subjects', 'Manage', () => _open(SubjectListScreen(userId: widget.userId)), [
    _isLoading
        ? const Padding(padding: EdgeInsets.only(top: 16), child: LinearProgressIndicator())
        : SizedBox(height: 112, child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _subjects.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final subject = _subjects[index];
              final color = _colorFor(subject['color_tag']);
              return Container(width: 220, padding: const EdgeInsets.all(16), decoration: _card(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(height: 10),
                Text(subject['subject_name'] ?? 'Subject', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4),
                Text('${subject['subject_code'] ?? 'Course'}  •  3 tasks remaining', style: const TextStyle(fontSize: 11, color: AppColors.lightTextSecondary)),
              ]));
            },
          )),
  ]);
  Color _colorFor(dynamic value) => value is String && value.startsWith('#') ? Color(int.parse(value.substring(1), radix: 16) | 0xFF000000) : AppColors.primary;
  Widget _section(String title, String action, VoidCallback onAction, List<Widget> children) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), const Spacer(), TextButton(onPressed: onAction, child: Text(action))]), ...children]);
  BoxDecoration _card() => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.lightBorder), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(.06), blurRadius: 12, offset: const Offset(0, 4))]);
  Widget _bottomNav() => BottomAppBar(height: 72, color: Colors.white, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_navItem(Icons.home_rounded, 'Home', 0), _navItem(Icons.check_circle_outline, 'Tasks', 1), FloatingActionButton(onPressed: _showAddMenu, backgroundColor: AppColors.primary, foregroundColor: Colors.white, child: const Icon(Icons.add)), _navItem(Icons.calendar_month_outlined, 'Schedule', 3), _navItem(Icons.person_outline, 'Profile', 4)]));
  Widget _navItem(IconData icon, String label, int index) => IconButton(tooltip: label, onPressed: () => _onNavTap(index), color: _selectedIndex == index ? AppColors.primary : AppColors.lightTextSecondary, icon: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 23), Text(label, style: const TextStyle(fontSize: 10))]));
}
