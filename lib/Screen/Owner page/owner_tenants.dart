import 'package:flutter/material.dart';

class OwnerTenants extends StatefulWidget {
  const OwnerTenants({Key? key}) : super(key: key);

  @override
  State<OwnerTenants> createState() => _OwnerTenantsState();
}

class _OwnerTenantsState extends State<OwnerTenants> {
  // Mock data for your tenants
  final List<Map<String, dynamic>> _tenants = [
    {
      "name": "Mark Santos",
      "room": "Room 04/B1",
      "status": "Paid",
      "isUpToDate": true,
    },
    {
      "name": "Bea Alonzo",
      "room": "Room 02/A",
      "status": "Pending",
      "isUpToDate": false,
    },
    {
      "name": "Juan Dela Cruz",
      "room": "Room 01/A",
      "status": "Overdue",
      "isUpToDate": false,
    },
    {
      "name": "Maria Clara",
      "room": "Room 05/C",
      "status": "Paid",
      "isUpToDate": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- HEADER & SEARCH BAR ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tenant Directory",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
              const SizedBox(height: 16),
              // Search Input
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search tenants...',
                  hintStyle: const TextStyle(color: Color(0xFF7F8C8D)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF7F8C8D)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00BCD4), width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- TENANT LIST ---
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: _tenants.length,
            itemBuilder: (context, index) {
              final tenant = _tenants[index];
              return _buildTenantCard(tenant);
            },
          ),
        ),
      ],
    );
  }

  // HELPER: Builds individual Tenant Cards
  Widget _buildTenantCard(Map<String, dynamic> tenant) {
    // Determine status colors
    Color statusColor;
    Color statusBgColor;
    
    if (tenant['status'] == 'Paid') {
      statusColor = const Color(0xFF2ECC71); // Green
      statusBgColor = const Color(0xFF2ECC71).withOpacity(0.1);
    } else if (tenant['status'] == 'Overdue') {
      statusColor = const Color(0xFFE74C3C); // Red
      statusBgColor = const Color(0xFFE74C3C).withOpacity(0.1);
    } else {
      statusColor = const Color(0xFFF39C12); // Orange for Pending
      statusBgColor = const Color(0xFFF39C12).withOpacity(0.1);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Tenant Avatar (Using initials for now)
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFF00BCD4).withOpacity(0.1),
            child: Text(
              tenant['name'].substring(0, 1), // First letter of name
              style: const TextStyle(
                color: Color(0xFF00BCD4),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Tenant Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenant['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34495E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tenant['room'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
                const SizedBox(height: 8),
                // Payment Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tenant['status'],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quick Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF00BCD4)),
                onPressed: () {
                  // TODO: Open chat with tenant
                  print("Message ${tenant['name']}");
                },
                tooltip: "Message",
              ),
              IconButton(
                icon: const Icon(Icons.phone_outlined, color: Color(0xFF2ECC71)),
                onPressed: () {
                  // TODO: Call tenant
                  print("Call ${tenant['name']}");
                },
                tooltip: "Call",
              ),
            ],
          ),
        ],
      ),
    );
  }
}