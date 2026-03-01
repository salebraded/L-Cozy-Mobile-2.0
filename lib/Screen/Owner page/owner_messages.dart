import 'package:flutter/material.dart';

class OwnerMessages extends StatefulWidget {
  const OwnerMessages({Key? key}) : super(key: key);

  @override
  State<OwnerMessages> createState() => _OwnerMessagesState();
}

class _OwnerMessagesState extends State<OwnerMessages> {
  // Mock data for recent chats
  final List<Map<String, dynamic>> _chats = [
    {
      "name": "Mark Santos",
      "room": "Room 04/B1",
      "lastMessage": "Hi! I just sent the payment for this month.",
      "time": "10:30 AM",
      "unreadCount": 2,
    },
    {
      "name": "Bea Alonzo",
      "room": "Room 02/A",
      "lastMessage": "Is the maintenance guy coming today?",
      "time": "Yesterday",
      "unreadCount": 1,
    },
    {
      "name": "Juan Dela Cruz",
      "room": "Room 01/A",
      "lastMessage": "Okay, noted on the new rules.",
      "time": "Monday",
      "unreadCount": 0,
    },
    {
      "name": "Maria Clara",
      "room": "Room 05/C",
      "lastMessage": "Thank you!",
      "time": "Last Week",
      "unreadCount": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), // Matches your app's background
      
      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF34495E)), // Back button color
        title: const Text(
          "Messages",
          style: TextStyle(color: Color(0xFF34495E), fontWeight: FontWeight.bold),
        ),
      ),

      // --- BODY ---
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
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
          ),

          // Message List
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return _buildChatTile(chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  // HELPER: Builds individual chat rows
  Widget _buildChatTile(Map<String, dynamic> chat) {
    bool hasUnread = chat['unreadCount'] > 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () {
          // TODO: Navigate to the actual Chat Room screen
          print("Opening chat with ${chat['name']}");
        },
        
        // Avatar
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFF00BCD4).withOpacity(0.1),
          child: Text(
            chat['name'].substring(0, 1),
            style: const TextStyle(
              color: Color(0xFF00BCD4),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        // Name and Room
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              chat['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.w600,
                color: const Color(0xFF34495E),
              ),
            ),
            Text(
              chat['time'],
              style: TextStyle(
                fontSize: 12,
                color: hasUnread ? const Color(0xFF00BCD4) : Colors.grey,
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),

        // Last Message & Unread Badge
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  chat['lastMessage'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: hasUnread ? const Color(0xFF34495E) : const Color(0xFF7F8C8D),
                    fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
              if (hasUnread)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE74C3C), // Red badge for unread
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chat['unreadCount'].toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}