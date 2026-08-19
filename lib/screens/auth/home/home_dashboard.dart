import 'package:flutter/material.dart';
import '../../../services/subject_service.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_constants.dart';
import '../../../widgets/theme/app_widgets.dart';
import '../../../widgets/theme/app_animations.dart';
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
  int _selectedNavIndex = 0;

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
    setState(() => _selectedNavIndex = index);
    
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      floatingActionButton: AppAnimations.scaleAnimation(
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          elevation: AppConstants.elevationLg,
          icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
          label: const Text(
            "Start Session",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StartSessionScreen(userId: widget.userId)),
            );
          },
        ),
      ),
      body: SafeArea(
        child: AppAnimations.fadeAnimation(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: AppConstants.paddingLg,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBg : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppConstants.radiusLg),
                    bottomRight: Radius.circular(AppConstants.radiusLg),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ${widget.userName}! 👋",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Welcome back to Study Sync",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: AppConstants.paddingSymmetricH,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Stats Row
                      AppAnimations.slideAnimation(
                        child: Row(
                          children: [
                            Expanded(
                              child: _quickStatCard(
                                context,
                                icon: Icons.book_rounded,
                                label: "Subjects",
                                value: _subjects.length.toString(),
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingMd),
                            Expanded(
                              child: _quickStatCard(
                                context,
                                icon: Icons.timer_rounded,
                                label: "Study Time",
                                value: "0h",
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingXl),
                      
                      // My Subjects Section
                      AppWidgets.sectionHeader(
                        context: context,
                        title: "My Subjects",
                        actionLabel: _subjects.isEmpty ? null : "Manage",
                        onAction: _subjects.isEmpty ? null : _goToSubjects,
                      ),
                      const SizedBox(height: AppConstants.spacingMd),
                      
                      // Subjects List or Empty State
                      _buildSubjectsContent(),
                      const SizedBox(height: AppConstants.spacing2xl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsContent() {
    if (_isLoading) {
      return Column(
        children: [
          AppWidgets.loadingSkeleton(width: double.infinity, height: 100),
          const SizedBox(height: AppConstants.spacingMd),
          AppWidgets.loadingSkeleton(width: double.infinity, height: 100),
        ],
      );
    }

    if (_subjects.isEmpty) {
      return AppWidgets.emptyState(
        context: context,
        icon: Icons.library_books_rounded,
        title: "No Subjects Yet",
        description: "Create your first subject to start organizing your study materials",
        actionButton: AppWidgets.primaryButton(
          label: "Add Subject",
          onPressed: _goToSubjects,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _subjects.length,
      itemBuilder: (context, index) {
        final subject = _subjects[index];
        final colorHex = subject["color_tag"] ?? "#5B4FE9";
        final color = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

        return AppAnimations.slideAnimation(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
            child: AppWidgets.accentCard(
              context: context,
              accentColor: color,
              child: Padding(
                padding: AppConstants.paddingCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacingMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject["subject_name"] ?? "Unnamed Subject",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${subject["subject_code"] ?? "CODE"} • ${subject["instructor"] ?? "Unknown"}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _quickStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: AppConstants.paddingCard,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
