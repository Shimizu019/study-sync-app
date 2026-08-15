import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1FF),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFFF3F1FF),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(child: Text("Unable to load profile."))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const CircleAvatar(radius: 40, backgroundColor: Color(0xFF5B4FE9)),
                      const SizedBox(height: 12),
                      Text(_user!["full_name"] ?? "",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(_user!["email"] ?? "", style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statCard("Level", _user!["level"].toString()),
                          _statCard("Streak", "${_user!["streak"]} 🔥"),
                          _statCard("Points", _user!["points"].toString()),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _statCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
