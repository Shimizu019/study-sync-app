import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';
import '../../../widgets/theme/app_colors.dart';
import '../../../widgets/theme/app_constants.dart';
import '../../../widgets/theme/app_widgets.dart';
import '../../../widgets/theme/app_animations.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final result = await ProfileService.getProfile(widget.userId);
    if (result["statusCode"] == 200) {
      setState(() {
        _user = result["body"]["user"];
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? Center(
                  child: AppWidgets.emptyState(
                    context: context,
                    icon: Icons.person_outline_rounded,
                    title: "Unable to Load Profile",
                    description: "Please check your connection and try again",
                  ),
                )
              : AppAnimations.fadeAnimation(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Profile Header
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
                            children: [
                              // Avatar
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primaryLight,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacingMd),
                              Text(
                                _user!["full_name"] ?? "Student",
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _user!["email"] ?? "",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXl),
                        
                        // Main Stats Section
                        Padding(
                          padding: AppConstants.paddingSymmetricH,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Gamification Stats Grid
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: AppConstants.spacingMd,
                                crossAxisSpacing: AppConstants.spacingMd,
                                childAspectRatio: 0.9,
                                children: [
                                  AppAnimations.slideAnimation(
                                    child: AppWidgets.statCard(
                                      context: context,
                                      value: _user!["level"].toString(),
                                      label: "Level",
                                      icon: Icons.star_rounded,
                                      iconColor: AppColors.levelUp,
                                    ),
                                  ),
                                  AppAnimations.slideAnimation(
                                    child: AppWidgets.statCard(
                                      context: context,
                                      value: _user!["streak"].toString(),
                                      label: "Streak",
                                      icon: Icons.local_fire_department_rounded,
                                      iconColor: AppColors.streakFire,
                                    ),
                                  ),
                                  AppAnimations.slideAnimation(
                                    child: AppWidgets.statCard(
                                      context: context,
                                      value: _user!["points"].toString(),
                                      label: "Points",
                                      icon: Icons.favorite_rounded,
                                      iconColor: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppConstants.spacingXl),
                              
                              // Level Progress Section
                              Text(
                                "Level Progress",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppConstants.spacingMd),
                              AppAnimations.slideAnimation(
                                child: AppWidgets.progressBar(
                                  progress: (_user!["points"] % 1000) / 1000,
                                  label: "Points to next level",
                                  color: AppColors.levelUp,
                                  height: 12,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacingXl),
                              
                              // Achievements Section
                              Text(
                                "Achievements",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppConstants.spacingMd),
                              
                              // Streak Achievement
                              if (_user!["streak"] > 0)
                                AppAnimations.slideAnimation(
                                  child: AppWidgets.achievementBadge(
                                    title: "🔥 Streak Master",
                                    subtitle: "Keep up your ${_user!["streak"]} day streak!",
                                    icon: Icons.local_fire_department_rounded,
                                    color: AppColors.streakFire,
                                  ),
                                ),
                              
                              if (_user!["streak"] > 0)
                                const SizedBox(height: AppConstants.spacingMd),
                              
                              // Level Achievement
                              if (_user!["level"] >= 5)
                                AppAnimations.slideAnimation(
                                  child: AppWidgets.achievementBadge(
                                    title: "⭐ Level ${_user!["level"]}",
                                    subtitle: "You've reached level ${_user!["level"]}!",
                                    icon: Icons.star_rounded,
                                    color: AppColors.levelUp,
                                  ),
                                ),
                              
                              if (_user!["level"] >= 5)
                                const SizedBox(height: AppConstants.spacingMd),
                              
                              // Points Achievement
                              if (_user!["points"] >= 500)
                                AppAnimations.slideAnimation(
                                  child: AppWidgets.achievementBadge(
                                    title: "💎 Points Collector",
                                    subtitle: "You've earned ${_user!["points"]} points!",
                                    icon: Icons.favorite_rounded,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              
                              const SizedBox(height: AppConstants.spacingXl),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
