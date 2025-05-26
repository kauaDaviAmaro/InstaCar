import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/navbar.dart';
import 'chat_page.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';

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

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  void loadChats() async {
    // Simulação de requisição ao backend (substituir por API real)
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      chats = [
        {
          "userId": "2",
          "name": "João",
          "LastMessage": "Oi! Como você está?",
          "lastMessageTime": "10:00",
          "initials": "J",
        },
        {
          "userId": "3",
          "name": "Maria",
          "LastMessage": "Vamos nos encontrar?",
          "lastMessageTime": "09:30",
          "initials": "M",
        },
        {
          "userId": "4",
          "name": "Carlos",
          "LastMessage": "Oi! Tudo bem?",
          "lastMessageTime": "08:45",
          "initials": "C",
        },
        {
          "userId": "5",
          "name": "Ana",
          "LastMessage": "Oi! Tudo certo?",
          "lastMessageTime": "08:00",
          "initials": "A",
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter chats based on the search query
    final filteredChats =
        chats.where((chat) {
          return chat["name"].toLowerCase().contains(searchQuery.toLowerCase());
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
          ),
          Expanded(
            // Wrap ListView in Expanded to avoid overflow
            child: ListView.builder(
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
                        builder:
                            (context) => ChatPage(
                              receiveName: chat["name"],
                              userId: widget.userId,
                              receiverId: chat["userId"],
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