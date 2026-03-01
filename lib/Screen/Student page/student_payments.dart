import 'package:flutter/material.dart';

class StudentPaymentsScreen extends StatefulWidget {
  const StudentPaymentsScreen({Key? key}) : super(key: key);

  @override
  State<StudentPaymentsScreen> createState() => _StudentPaymentsScreenState();
}

class _StudentPaymentsScreenState extends State<StudentPaymentsScreen> {
  // Mock data for transaction history
  final List<Map<String, dynamic>> _transactions = [
    {
      "title": "March Rent - Sunrise Living",
      "date": "Feb 25, 2026",
      "amount": "\$450.00",
      "status": "Paid",
      "icon": Icons.home,
    },
    {
      "title": "Security Deposit",
      "date": "Feb 10, 2026",
      "amount": "\$200.00",
      "status": "Paid",
      "icon": Icons.security,
    },
    {
      "title": "Application Fee",
      "date": "Feb 05, 2026",
      "amount": "\$25.00",
      "status": "Paid",
      "icon": Icons.description,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // App background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "Payments",
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF34495E)
                ),
              ),
              const SizedBox(height: 25),

              // Outstanding Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34495E), Color(0xFF2C3E50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF34495E).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Next Payment Due",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "\$450.00",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 36, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Due: April 1, 2026",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Pay Now tapped!");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3498DB), // Accent Blue
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Saved Payment Methods Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment Methods",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF34495E)
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Add new payment method");
                    },
                    child: const Text(
                      "+ Add New",
                      style: TextStyle(
                        color: Color(0xFF3498DB), 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              // 🌟 UPDATED: GCash Payment Method 🌟
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF5FF), // Light blue background for the icon
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Using a mobile phone icon to represent the GCash e-wallet
                      child: const Icon(Icons.phone_android, color: Color(0xFF005CFE)), // GCash Blue
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GCash",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              color: Color(0xFF34495E),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "0917 *** 4242", // Masked mobile number
                            style: TextStyle(
                              color: Color(0xFF7F8C8D), 
                              fontSize: 12
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Linked", 
                      style: TextStyle(color: Color(0xFF7F8C8D), fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Transaction History Header
              const Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF34495E)
                ),
              ),
              const SizedBox(height: 15),

              // Transaction List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionTile(_transactions[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HELPER METHOD: Builds Individual Transaction Tiles
  Widget _buildTransactionTile(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction['icon'], color: const Color(0xFF1ABC9C)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Color(0xFF34495E)
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['date'],
                  style: const TextStyle(
                    color: Color(0xFF7F8C8D), 
                    fontSize: 12
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16, 
                  color: Color(0xFF34495E)
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['status'],
                style: const TextStyle(
                  color: Color(0xFF27AE60), 
                  fontSize: 12, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}