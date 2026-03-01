import 'package:flutter/material.dart';

class StudentBookingsScreen extends StatefulWidget {
  const StudentBookingsScreen({Key? key}) : super(key: key);

  @override
  State<StudentBookingsScreen> createState() => _StudentBookingsScreenState();
}

class _StudentBookingsScreenState extends State<StudentBookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for bookings
  final List<Map<String, dynamic>> _bookings = [
    {
      "dormName": "Sunrise Student Living",
      "location": "0.5 miles from campus",
      "moveInDate": "Aug 15, 2026",
      "price": "\$450 / month",
      "status": "Active", 
      "imageIcon": Icons.apartment,
    },
    {
      "dormName": "The Hub Residences",
      "location": "1.2 miles from campus",
      "moveInDate": "Sep 01, 2026",
      "price": "\$350 / month",
      "status": "Pending",
      "imageIcon": Icons.domain,
    },
    {
      "dormName": "Campus View Apartments",
      "location": "0.2 miles from campus",
      "moveInDate": "Jan 10, 2025",
      "price": "\$400 / month",
      "status": "Completed",
      "imageIcon": Icons.home_work,
    }
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 3 tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // App background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "My Bookings",
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF34495E)
                ),
              ),
            ),

            // Custom Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                // 🌟 ADDED THIS LINE to stretch the blue background evenly 🌟
                indicatorSize: TabBarIndicatorSize.tab, 
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF3498DB), // Student Blue
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF7F8C8D),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "Active"),
                  Tab(text: "Pending"),
                  Tab(text: "Past"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tab Views (The lists corresponding to each tab)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBookingList("Active"),
                  _buildBookingList("Pending"),
                  _buildBookingList("Completed"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HELPER METHOD: Filters and builds the list based on the status
  Widget _buildBookingList(String filterStatus) {
    // Filter the mock data based on the tab selected
    final filteredBookings = _bookings.where((b) => b['status'] == filterStatus).toList();

    if (filteredBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 60, color: const Color(0xFF7F8C8D).withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              "No $filterStatus bookings",
              style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: filteredBookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(filteredBookings[index]);
      },
    );
  }

  // HELPER METHOD: Builds the individual booking card
  Widget _buildBookingCard(Map<String, dynamic> booking) {
    // Determine badge color based on status
    Color badgeColor;
    Color badgeBgColor;
    if (booking['status'] == "Active") {
      badgeColor = const Color(0xFF27AE60); // Green
      badgeBgColor = const Color(0xFFEAFBF1);
    } else if (booking['status'] == "Pending") {
      badgeColor = const Color(0xFFF39C12); // Orange
      badgeBgColor = const Color(0xFFFEF5E7);
    } else {
      badgeColor = const Color(0xFF7F8C8D); // Grey
      badgeBgColor = const Color(0xFFF2F4F4);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Image & Core Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFECF0F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(booking['imageIcon'], size: 40, color: const Color(0xFFBDC3C7)),
              ),
              const SizedBox(width: 16),
              
              // Text Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['dormName'],
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF34495E)
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Color(0xFF7F8C8D)),
                        const SizedBox(width: 4),
                        Text(
                          booking['location'],
                          style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking['price'],
                          style: const TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                            color: Color(0xFF3498DB)
                          ),
                        ),
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeBgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            booking['status'],
                            style: TextStyle(
                              color: badgeColor, 
                              fontWeight: FontWeight.bold, 
                              fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          
          const Divider(height: 30, color: Color(0xFFECF0F1)),
          
          // Bottom Row: Dates and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Move-in Date",
                    style: TextStyle(color: Color(0xFF7F8C8D), fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    booking['moveInDate'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600, 
                      color: Color(0xFF34495E)
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  print("View Details tapped for ${booking['dormName']}");
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3498DB), 
                  side: const BorderSide(color: Color(0xFF3498DB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("View Details"),
              )
            ],
          )
        ],
      ),
    );
  }
}