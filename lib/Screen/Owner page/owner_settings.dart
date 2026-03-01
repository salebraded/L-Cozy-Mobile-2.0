import 'package:flutter/material.dart';

// 🌟 1. IMPORT YOUR LOGIN SCREEN 🌟
import '../Login page/login_screen.dart'; 

class OwnerSettings extends StatelessWidget {
  final String userName; // 🌟 Added to receive the name from Home Screen

  const OwnerSettings({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), 
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF34495E)),
        title: const Text(
          "Settings",
          style: TextStyle(color: Color(0xFF34495E), fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. Profile Header (Updated to show name)
          _buildProfileHeader(),
          const SizedBox(height: 24),

          // 2. Account Group
          _buildSettingsGroup(
            title: "Account",
            items: [
              _buildSettingsTile(Icons.person_outline, "Personal Information", () {}),
              _buildSettingsTile(Icons.account_balance, "Bank Accounts (Receiving)", () {}),
              _buildSettingsTile(Icons.security, "Security & Password", () {}),
            ],
          ),
          const SizedBox(height: 20),

          // 3. Preferences Group
          _buildSettingsGroup(
            title: "Preferences",
            items: [
              _buildSettingsTile(Icons.notifications_none, "Notifications", () {}),
              _buildSettingsTile(Icons.language, "Language", () {}),
              _buildSettingsTile(Icons.dark_mode_outlined, "Dark Mode", () {}),
            ],
          ),
          const SizedBox(height: 20),

          // 4. Support Group
          _buildSettingsGroup(
            title: "Support",
            items: [
              _buildSettingsTile(Icons.help_outline, "Help Center", () {}),
              _buildSettingsTile(Icons.article_outlined, "Terms of Service", () {}),
            ],
          ),
          const SizedBox(height: 32),

          // 🌟 2. UPDATED LOGOUT BUTTON 🌟
          ElevatedButton(
            onPressed: () {
              // Clears history so user can't go 'back' to the dashboard
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFE74C3C), 
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              side: const BorderSide(color: Color(0xFFE74C3C)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Log Out",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // =========================================================================
  // HELPER METHODS
  // =========================================================================

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Shows dynamic initial based on name
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF00BCD4).withOpacity(0.1),
            child: Text(
              userName.isNotEmpty ? userName[0].toUpperCase() : "O",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00BCD4)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName, // 🌟 Now shows the actual user name
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34495E),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Property Owner",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF00BCD4)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7F8C8D),
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF34495E)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF34495E),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}