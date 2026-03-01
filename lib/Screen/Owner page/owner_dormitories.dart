import 'package:flutter/material.dart';

class OwnerDormitories extends StatefulWidget {
  const OwnerDormitories({Key? key}) : super(key: key);

  @override
  State<OwnerDormitories> createState() => _OwnerDormitoriesState();
}

class _OwnerDormitoriesState extends State<OwnerDormitories> {
  // Mock data for your dorm rooms
  final List<Map<String, dynamic>> _dorms = [
    {
      "roomName": "Room 01/A",
      "price": "\$200 / month",
      "capacity": "4/4",
      "status": "Full",
      "isAvailable": false,
    },
    {
      "roomName": "Room 02/A",
      "price": "\$150 / month",
      "capacity": "1/2",
      "status": "Available",
      "isAvailable": true,
    },
    {
      "roomName": "Room 04/B1",
      "price": "\$250 / month",
      "capacity": "0/2",
      "status": "Available",
      "isAvailable": true,
    },
    {
      "roomName": "Room 05/C",
      "price": "\$180 / month",
      "capacity": "2/2",
      "status": "Full",
      "isAvailable": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- TOP ACTION BAR ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Manage Rooms",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to "Add Room" Form
                  print("Add new room clicked");
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                label: const Text(
                  "Add Room",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4), // L'COZY Cyan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),

        // --- DORMITORY LIST ---
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: _dorms.length,
            itemBuilder: (context, index) {
              final dorm = _dorms[index];
              return _buildDormCard(dorm);
            },
          ),
        ),
      ],
    );
  }

  // HELPER: Builds individual Dormitory Cards
  Widget _buildDormCard(Map<String, dynamic> dorm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Icon / Image Placeholder
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bed, color: Color(0xFF7F8C8D), size: 30),
          ),
          const SizedBox(width: 16),
          
          // Room Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dorm['roomName'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34495E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dorm['price'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00BCD4), // Cyan accent for price
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      "Capacity: ${dorm['capacity']}",
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Badge & Action Menu
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 3-dot menu for editing/deleting
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {
                  // TODO: Show edit/delete bottom sheet
                },
              ),
              const SizedBox(height: 12),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: dorm['isAvailable'] 
                      ? const Color(0xFF2ECC71).withOpacity(0.1) // Light Green
                      : const Color(0xFFE74C3C).withOpacity(0.1), // Light Red
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  dorm['status'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: dorm['isAvailable'] 
                        ? const Color(0xFF2ECC71) 
                        : const Color(0xFFE74C3C),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}