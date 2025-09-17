import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/navbar.dart';
import 'chat_page.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';
import 'package:instacar/core/services/chat_service.dart';
import 'package:instacar/core/services/user_service.dart';

class ChatListPage extends StatefulWidget {
  final String userId;

  const ChatListPage({super.key, required this.userId});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Map<String, dynamic>> chats = [];
  int currentIndex = 3;
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  void loadChats() async {
    try {
      print('Loading chats for userId: ${widget.userId}');
      setState(() {
        isLoading = true;
      });
      
      final conversations = await ChatService.getUserConversations();
      print('Found ${conversations.length} conversations');
      final List<Map<String, dynamic>> chatList = [];
      
      for (var conversation in conversations) {
        print('Processing conversation: ${conversation['id']}');
        // Get the other user's ID
        final otherUserId = conversation['user1Id'] == widget.userId 
            ? conversation['user2Id'] 
            : conversation['user1Id'];
        
        print('Other user ID: $otherUserId');
        
        // Get user details
        try {
          final userDetails = await UserService.getUserById(otherUserId);
          print('User details: ${userDetails['name']}');
          final lastMessage = conversation['Messages']?.isNotEmpty == true 
              ? conversation['Messages'][0] 
              : null;
          
          chatList.add({
            "userId": otherUserId,
            "name": userDetails['name'] ?? 'Usuário',
            "LastMessage": lastMessage?['message'] ?? 'Nenhuma mensagem',
            "lastMessageTime": lastMessage != null 
                ? _formatTime(DateTime.parse(lastMessage['createdAt']))
                : '',
            "initials": _getInitials(userDetails['name'] ?? 'U'),
            "conversationId": conversation['id'],
          });
          print('Added chat: ${userDetails['name']}');
        } catch (e) {
          print('Error loading user details for $otherUserId: $e');
        }
      }
      
      print('Final chat list length: ${chatList.length}');
      setState(() {
        chats = chatList;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading chats: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${dateTime.day}/${dateTime.month}';
    } else {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // Normalize search query
    final normalizedQuery = removeDiacritics(searchQuery).toLowerCase();

    // Filter chats based on normalized search query
    final filteredChats =
        chats.where((chat) {
          final normalizedName = removeDiacritics(chat["name"]).toLowerCase();
          return normalizedName.contains(normalizedQuery);
        }).toList();

    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            title: "Chats",
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            showFilter: false,
          ),
          Expanded(
            // Wrap ListView in Expanded to avoid overflow
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredChats.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Nenhum chat encontrado',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Seus chats aparecerão aqui',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredChats.length,
                        itemBuilder: (context, index) {
                          final chat = filteredChats[index];
                          return ListTile(
                            leading: CircleAvatar(child: Text(chat["initials"])),
                            title: Text(chat["name"]),
                            subtitle: Text(chat["LastMessage"]),
                            trailing: Text(chat["lastMessageTime"]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    receiveName: chat["name"],
                                    userId: widget.userId,
                                    receiverId: chat["userId"],
                                    conversationId: chat["conversationId"],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: currentIndex),
    );
  }
}
