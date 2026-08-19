import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/profile_service.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const ProfileScreen({
    super.key,
    required this.userId,
    this.themeMode = ThemeMode.system,
    this.onThemeModeChanged = _ignoreThemeChange,
  });

  static void _ignoreThemeChange(ThemeMode _) {}

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _user = const {};
  bool _isLoading = true;
  late ThemeMode _selectedThemeMode;
  final Map<String, bool> _notifications = {
    'Class reminders': true,
    'Assignment reminders': true,
    'Exam reminders': true,
    'Study session reminders': true,
    'Daily summary': true,
  };

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = widget.themeMode;
    _loadProfile();
    _loadNotificationSettings();
  }

  Future<void> _loadProfile() async {
    try {
      final result = await ProfileService.getProfile(widget.userId);
      if (result['statusCode'] == 200 && result['body']['user'] is Map) {
        _user = Map<String, dynamic>.from(result['body']['user']);
      }
    } catch (_) {}
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      for (final key in _notifications.keys) {
        final storageKey = 'notification_${key.toLowerCase().replaceAll(' ', '_')}';
        _notifications[key] = prefs.getBool(storageKey) ?? _notifications[key]!;
      }
    });
  }

  Future<void> _toggleNotification(String title, bool value) async {
    setState(() => _notifications[title] = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_${title.toLowerCase().replaceAll(' ', '_')}', value);
  }

  String get _name => (_user['full_name'] ?? 'Student').toString();
  String get _email => (_user['email'] ?? 'student@studysync.app').toString();
  String get _course => (_user['course'] ?? _user['program'] ?? _user['year_level'] ?? _user['student_id'] ?? 'Academic information unavailable').toString();
  String get _themeLabel => switch (_selectedThemeMode) {
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
    _ => 'System Default',
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
              children: [
                _profileHeader(colors),
                const SizedBox(height: 24),
                _section('Appearance', [
                  _settingRow(Icons.palette_outlined, 'Appearance', _themeLabel, trailing: const Icon(Icons.chevron_right), onTap: _chooseTheme),
                ]),
                _section('Notifications', [
                  for (final entry in _notifications.entries)
                    _settingRow(Icons.notifications_none, entry.key, entry.value ? 'On' : 'Off', trailing: Switch(value: entry.value, onChanged: (value) => _toggleNotification(entry.key, value))),
                ]),
                _section('Account', [
                  _settingRow(Icons.edit_outlined, 'Edit profile', 'Update your student information', trailing: const Icon(Icons.chevron_right), onTap: () => _showUnavailable('Profile editing is not connected to the server yet.')),
                  _settingRow(Icons.email_outlined, 'Email', _email),
                  _settingRow(Icons.school_outlined, 'Student information', _course),
                ]),
                _section('Security', [
                  _settingRow(Icons.lock_outline, 'Change password', 'Available after account security is connected', enabled: false),
                  _settingRow(Icons.devices_outlined, 'Active sessions', 'Available after session management is connected', enabled: false),
                ]),
                _section('Help & Support', [
                  _settingRow(Icons.help_outline, 'Help & Support', 'Get help with StudySync', trailing: const Icon(Icons.chevron_right), onTap: () => _showUnavailable('Support center coming soon.')),
                  _settingRow(Icons.info_outline, 'About StudySync', 'Study planner for focused students', trailing: const Icon(Icons.chevron_right), onTap: () => showAboutDialog(context: context, applicationName: 'StudySync', applicationVersion: '1.0.0', children: const [Text('Plan classes, tasks, deadlines, and focused study sessions in one place.')])),
                  _settingRow(Icons.privacy_tip_outlined, 'Privacy Policy', 'Available in the web release', enabled: false),
                ]),
                const SizedBox(height: 16),
                TextButton.icon(onPressed: _confirmLogout, icon: const Icon(Icons.logout, color: AppColors.error), label: const Text('Sign out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w800))),
              ],
            ),
    );
  }

  Widget _profileHeader(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: colors.outlineVariant)),
      child: Row(children: [
        CircleAvatar(radius: 34, backgroundColor: AppColors.primaryBg, child: Text(_name.isEmpty ? 'S' : _name[0].toUpperCase(), style: const TextStyle(color: AppColors.primary, fontSize: 25, fontWeight: FontWeight.w900))),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4), Text(_email, style: TextStyle(color: colors.onSurfaceVariant)),
          const SizedBox(height: 3), const Text('Student', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
          Text(_course, style: TextStyle(color: colors.onSurfaceVariant)),
        ])),
      ]),
    );
  }

  Widget _section(String title, List<Widget> rows) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: Theme.of(context).colorScheme.outlineVariant)),
          child: Column(children: rows),
        ),
      ]),
    );
  }

  Widget _settingRow(IconData icon, String title, String value, {Widget? trailing, VoidCallback? onTap, bool enabled = true}) {
    return Opacity(
      opacity: enabled ? 1 : .5,
      child: ListTile(
        enabled: enabled,
        onTap: onTap,
        leading: Icon(icon, color: enabled ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(value),
        trailing: trailing,
      ),
    );
  }

  Future<void> _chooseTheme() async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const ListTile(title: Text('Appearance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
        for (final mode in ThemeMode.values)
          RadioListTile<ThemeMode>(title: Text(_modeLabel(mode)), value: mode, groupValue: _selectedThemeMode, onChanged: (value) => Navigator.pop(context, value)),
        const SizedBox(height: 12),
      ])),
    );
    if (selected != null) {
      setState(() => _selectedThemeMode = selected);
      await StudySyncThemeController.setMode(selected);
      widget.onThemeModeChanged(selected);
    }
  }

  String _modeLabel(ThemeMode mode) => switch (mode) { ThemeMode.light => 'Light', ThemeMode.dark => 'Dark', _ => 'System Default' };
  void _showUnavailable(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(context: context, builder: (context) => AlertDialog(title: const Text('Sign out?'), content: const Text('You will return to the login screen.'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sign out'))]));
    if (shouldLogout == true && mounted) Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
