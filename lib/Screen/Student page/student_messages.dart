import 'package:flutter/material.dart';

class StudentMessagesScreen extends StatefulWidget {
  const StudentMessagesScreen({Key? key}) : super(key: key);

  @override
  State<StudentMessagesScreen> createState() => _StudentMessagesScreenState();
}

class _StudentMessagesScreenState extends State<StudentMessagesScreen> {
  // Mock data for active conversations
  final List<Map<String, dynamic>> _chats = [
    {
      "ownerName": "Mr. John Davis",
      "dormName": "Sunrise Student Living",
      "lastMessage": "Yes, the WiFi is included in the rent.",
      "time": "10:30 AM",
      "unreadCount": 2,
    },
    {
      "ownerName": "Sarah Jenkins",
      "dormName": "The Hub Residences",
      "lastMessage": "Great! See you on Tuesday for the viewing.",
      "time": "Yesterday",
      "unreadCount": 0,
    },
    {
      "ownerName": "Cozy Corner Management",
      "dormName": "Cozy Corner Dorms",
      "lastMessage": "Please submit your ID for verification.",
      "time": "Monday",
      "unreadCount": 1,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // App background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Messages",
                    style: TextStyle(
                      fontSize: 28, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF34495E)
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_square, color: Color(0xFF3498DB)),
                    onPressed: () {
                      print("Compose new message tapped");
                    },
                  )
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search messages...',
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
            const SizedBox(height: 20),

            // Chat List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: _chats.length,
                itemBuilder: (context, index) {
                  return _buildChatTile(_chats[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HELPER METHOD: Builds Individual Chat Tiles
  Widget _buildChatTile(Map<String, dynamic> chat) {
    bool hasUnread = chat['unreadCount'] > 0;

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to the actual Chat Room Screen
        print("Opening chat with ${chat['ownerName']}");
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFF3498DB).withOpacity(0.1),
              child: const Icon(Icons.person, color: Color(0xFF3498DB), size: 30),
            ),
            const SizedBox(width: 16),
            
            // Chat Info (Name, Dorm, Last Message)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat['ownerName'],
                    style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF34495E)
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat['dormName'],
                    style: const TextStyle(
                      fontSize: 12, 
                      color: Color(0xFF3498DB), 
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    chat['lastMessage'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14, 
                      color: hasUnread ? const Color(0xFF34495E) : const Color(0xFF7F8C8D),
                      fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            
            // Time and Unread Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: hasUnread ? const Color(0xFF3498DB) : const Color(0xFF7F8C8D),
                    fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE74C3C), // Notification Red
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat['unreadCount'].toString(),
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 12, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 24), // Placeholder to keep alignment when no badge
              ],
            )
          ],
        ),
      ),
    );
  }
}