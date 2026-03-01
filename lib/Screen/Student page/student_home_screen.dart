import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 🌟 ADDED IMPORTS FOR ALL YOUR NEW SCREENS 🌟
import 'student_messages.dart';
import 'student_bookings.dart';
import 'student_payments.dart';
import 'student_profiles.dart';

class StudentHomeScreen extends StatefulWidget {
  final String userName; // Received from Login

  const StudentHomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _dorms = [];
  bool _isLoadingDorms = true;

  @override
  void initState() {
    super.initState();
    _fetchDorms();
  }

  // API: Fetch dormitories from database
  Future<void> _fetchDorms() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/lcozy_api/get_dorms.php'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() {
            _dorms = List<Map<String, dynamic>>.from(data['dormitories']);
            _isLoadingDorms = false;
          });
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to load dormitories');
      }
    } catch (e) {
      setState(() {
        _isLoadingDorms = false;
      });
      print('Error loading dorms: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🌟 FIXED: Removed 'const' and passed widget.userName to the Profile Screen
    final List<Widget> _pages = [
      _buildHomeFeed(),                                      // Index 0
      const StudentMessagesScreen(),                         // Index 1
      const Center(child: Text("Saved Items coming soon!")), // Index 2
      const StudentBookingsScreen(),                         // Index 3
      const StudentPaymentsScreen(),                         // Index 4
      StudentProfileScreen(userName: widget.userName),       // Index 5 (FIXED)
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), 
      
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF3498DB), 
        unselectedItemColor: const Color(0xFF7F8C8D),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, 
        selectedFontSize: 11, 
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), activeIcon: Icon(Icons.account_balance_wallet), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeFeed() {
    String firstName = widget.userName.split(' ')[0];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $firstName 👋",
                    style: const TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Find your perfect dorm",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFF3498DB),
                child: Text(
                  widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : "S",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )
            ],
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search dorms, locations...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF7F8C8D)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF34495E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.tune, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip("All", true),
                _buildCategoryChip("Near Campus", false),
                _buildCategoryChip("Top Rated", false),
                _buildCategoryChip("Budget", false),
                _buildCategoryChip("Solo Rooms", false),
              ],
            ),
          ),
          const SizedBox(height: 25),

          const Text(
            "Recommended for you",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
          ),
          const SizedBox(height: 15),

          // Show loading, empty state, or list of dormitories from database
          _isLoadingDorms
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3498DB)),
                  ),
                )
              : _dorms.isEmpty
                  ? const Center(
                      child: Text('No dormitories available'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _dorms.length,
                      itemBuilder: (context, index) {
                        return _buildDormCard(_dorms[index]);
                      },
                    ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3498DB) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? const Color(0xFF3498DB) : const Color(0xFFE0E0E0)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF7F8C8D),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDormCard(Map<String, dynamic> dorm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: Color(0xFFBDC3C7),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: dorm['image_url'] != null && dorm['image_url'].toString().isNotEmpty
                ? Image.network(
                    dorm['image_url'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_outlined, size: 50, color: Colors.white);
                    },
                  )
                : const Icon(Icons.image_outlined, size: 50, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        dorm['name'] ?? 'N/A',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '4.5',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF7F8C8D)),
                    const SizedBox(width: 4),
                    Text(
                      dorm['location'] ?? 'N/A',
                      style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${dorm['price_per_month']} / month',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3498DB)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F8F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${dorm['available_slots']} Beds Left",
                        style: const TextStyle(color: Color(0xFF1ABC9C), fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}