import 'package:flutter/material.dart';
import '../Login page/login_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  final String userName; // 🌟 Added to receive the name

  const StudentProfileScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Profile", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF34495E))),
              ),
              const SizedBox(height: 30),

              // 🌟 Avatar & User Info Updated
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFF3498DB),
                      child: Text(
                        widget.userName[0].toUpperCase(), // 🌟 Initial
                        style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.userName, // 🌟 Real Name
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Verified Student", // 🌟 Role
                      style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              _buildMenuSection(
                "Account Settings",
                [
                  _buildMenuItem(Icons.person_outline, "Personal Information"),
                  _buildMenuItem(Icons.lock_outline, "Change Password"),
                  _buildMenuItem(Icons.notifications_none, "Notifications"),
                ],
              ),
              const SizedBox(height: 25),

              _buildMenuSection(
                "Preferences",
                [
                  _buildMenuItem(Icons.language, "Language", trailingText: "English"),
                  _buildMenuItem(Icons.dark_mode_outlined, "Dark Mode", isToggle: true),
                ],
              ),
              const SizedBox(height: 25),

              _buildMenuSection(
                "Support",
                [
                  _buildMenuItem(Icons.help_outline, "Help Center"),
                  _buildMenuItem(Icons.description_outlined, "Terms & Conditions"),
                ],
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFE74C3C)),
                  label: const Text("Log Out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFE74C3C))),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFE74C3C), width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7F8C8D))),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailingText, bool isToggle = false}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF34495E)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF34495E))),
      trailing: isToggle ? Switch(value: false, onChanged: (v) {}, activeColor: const Color(0xFF3498DB)) : const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}