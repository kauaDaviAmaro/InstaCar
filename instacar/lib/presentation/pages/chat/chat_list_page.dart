import 'package:flutter/material.dart';
import 'chat_page.dart';

class ChatListPage extends StatefulWidget {
  final String userId;

  const ChatListPage({super.key, required this.userId});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Map<String, dynamic>> chats = [];

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
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
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
                        userId: widget.userId,
                        receiverId: chat["userId"],
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
