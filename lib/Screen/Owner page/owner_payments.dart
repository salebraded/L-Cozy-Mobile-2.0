import 'package:flutter/material.dart';

class OwnerPayments extends StatefulWidget {
  const OwnerPayments({Key? key}) : super(key: key);

  @override
  State<OwnerPayments> createState() => _OwnerPaymentsState();
}

class _OwnerPaymentsState extends State<OwnerPayments> {
  // Mock data for recent payment transactions
  final List<Map<String, dynamic>> _transactions = [
    {
      "tenant": "Mark Santos",
      "room": "Room 04/B1",
      "amount": "\$250",
      "date": "Feb 24, 2026",
      "status": "Pending", // Needs owner approval
    },
    {
      "tenant": "Bea Alonzo",
      "room": "Room 02/A",
      "amount": "\$150",
      "date": "Feb 20, 2026",
      "status": "Approved",
    },
    {
      "tenant": "Maria Clara",
      "room": "Room 05/C",
      "amount": "\$180",
      "date": "Feb 15, 2026",
      "status": "Approved",
    },
    {
      "tenant": "Juan Dela Cruz",
      "room": "Room 01/A",
      "amount": "\$200",
      "date": "Feb 10, 2026",
      "status": "Rejected", // Maybe the receipt was blurry
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- TOP SUMMARY CARDS ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  title: "Collected this Month",
                  value: "\$860",
                  icon: Icons.account_balance_wallet,
                  color: const Color(0xFF2ECC71), // Green
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryCard(
                  title: "Pending Review",
                  value: "1",
                  icon: Icons.pending_actions,
                  color: const Color(0xFFF39C12), // Orange
                ),
              ),
            ],
          ),
        ),

        // --- TRANSACTIONS HEADER ---
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF34495E),
            ),
          ),
        ),

        // --- TRANSACTIONS LIST ---
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final transaction = _transactions[index];
              return _buildTransactionCard(transaction);
            },
          ),
        ),
      ],
    );
  }

  // HELPER: Builds the top summary boxes
  Widget _buildSummaryCard({required String title, required String value, required IconData icon, required Color color}) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF34495E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7F8C8D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // HELPER: Builds individual Transaction Cards
  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    // Determine status colors
    Color statusColor;
    Color statusBgColor;
    
    if (transaction['status'] == 'Approved') {
      statusColor = const Color(0xFF2ECC71); 
      statusBgColor = const Color(0xFF2ECC71).withOpacity(0.1);
    } else if (transaction['status'] == 'Rejected') {
      statusColor = const Color(0xFFE74C3C); 
      statusBgColor = const Color(0xFFE74C3C).withOpacity(0.1);
    } else {
      statusColor = const Color(0xFFF39C12); // Pending
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
          // Receipt Icon
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF00BCD4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.receipt_long, color: Color(0xFF00BCD4)),
          ),
          const SizedBox(width: 16),
          
          // Transaction Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['tenant'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34495E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${transaction['room']} • ${transaction['date']}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
                const SizedBox(height: 8),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    transaction['status'],
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

          // Amount & Action Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
              const SizedBox(height: 12),
              // Review Button (Only show prominently if pending)
              if (transaction['status'] == 'Pending')
                ElevatedButton(
                  onPressed: () {
                    // TODO: Open receipt image and show Approve/Reject bottom sheet
                    print("Reviewing payment for ${transaction['tenant']}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4), // Cyan
                    minimumSize: const Size(70, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Review", style: TextStyle(color: Colors.white, fontSize: 12)),
                )
              else
                TextButton(
                  onPressed: () {
                    print("View receipt for ${transaction['tenant']}");
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(70, 32),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text("View", style: TextStyle(color: Color(0xFF7F8C8D), fontSize: 13)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}