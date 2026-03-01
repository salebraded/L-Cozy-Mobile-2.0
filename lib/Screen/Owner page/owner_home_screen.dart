import 'package:flutter/material.dart';

// 🌟 IMPORT THE LOGIN SCREEN 🌟
import '../Login page/login_screen.dart'; 

// IMPORTING YOUR OTHER SCREENS
import 'owner_dormitories.dart';
import 'owner_tenants.dart';
import 'owner_payments.dart';
import 'owner_reports.dart';
import 'owner_messages.dart';
import 'owner_settings.dart';

class OwnerHomeScreen extends StatefulWidget {
  final String userName; 

  const OwnerHomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _recent_bookings = [
    {"room": "Room 04/B1", "tenant": "Mark Santos", "status": "Pending"},
    {"room": "Room 02/A", "tenant": "Bea Alonzo", "status": "Pending"},
  ];

  void _onPageSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); 
  }

  final List<String> _pageTitles = [
    "Dashboard",
    "Manage Dormitories",
    "Tenant Directory",
    "Payments",
    "Financial Reports",
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildDashboardContent(), 
      const OwnerDormitories(), 
      const OwnerTenants(),     
      const OwnerPayments(),    
      const OwnerReports(),     
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), 
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF34495E)), 
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(color: Color(0xFF34495E), fontWeight: FontWeight.bold),
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF00BCD4)),
              accountName: Text(
                widget.userName, 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              accountEmail: const Text("Property Owner"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : "O",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00BCD4)),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(Icons.dashboard, "Dashboard", isSelected: _selectedIndex == 0, onTap: () => _onPageSelected(0)),
                  _buildDrawerItem(Icons.domain, "Dormitories", isSelected: _selectedIndex == 1, onTap: () => _onPageSelected(1)),
                  _buildDrawerItem(Icons.people, "Tenants", isSelected: _selectedIndex == 2, onTap: () => _onPageSelected(2)),
                  _buildDrawerItem(Icons.payment, "Payments", isSelected: _selectedIndex == 3, onTap: () => _onPageSelected(3)),
                  _buildDrawerItem(Icons.bar_chart, "Reports", isSelected: _selectedIndex == 4, onTap: () => _onPageSelected(4)),
                  
                  const Divider(), 

                  _buildDrawerItem(Icons.message, "Messages", isSelected: false, onTap: () {
                    Navigator.pop(context); 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerMessages()));
                  }),
                  
                  _buildDrawerItem(Icons.settings, "Settings", isSelected: false, onTap: () {
                    Navigator.pop(context); 
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => OwnerSettings(userName: widget.userName))
                    );
                  }),
                  
                  const Divider(),
                  
                  // 🌟 UPDATED LOGOUT BUTTON 🌟
                  _buildDrawerItem(
                    Icons.logout, 
                    "Logout", 
                    isSelected: false, 
                    onTap: () {
                      // This clears the navigation stack so the user cannot press 'back' to return home
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: _pages[_selectedIndex],
    );
  }

  // (The rest of the helper methods _buildDashboardContent, _buildDrawerItem, etc. remain exactly the same)
  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back, ${widget.userName.split(' ')[0]}!", 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStatCard("Total Dorms", "04"),
                  _buildStatCard("Occupied Rooms", "40"),
                  _buildStatCard("Monthly Revenue", "₱8,600"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Revenue Chart",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.show_chart, size: 60, color: Color(0xFF00BCD4)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Bookings",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _recent_bookings.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return _buildBookingItem(_recent_bookings[index]);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {bool isSelected = false, VoidCallback? onTap}) {
    return Container(
      color: isSelected ? Colors.cyan.withOpacity(0.1) : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: isSelected ? const Color(0xFF00BCD4) : const Color(0xFF34495E)),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF00BCD4) : const Color(0xFF34495E),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: onTap, 
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey)),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
        ],
      ),
    );
  }

  Widget _buildBookingItem(Map<String, dynamic> booking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(booking['room'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34495E), fontSize: 16)),
              const SizedBox(height: 4),
              Text(booking['tenant'], style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle, color: Color(0xFF2ECC71))),
              IconButton(onPressed: () {}, icon: const Icon(Icons.cancel, color: Color(0xFFE74C3C))),
            ],
          )
        ],
      ),
    );
  }
}