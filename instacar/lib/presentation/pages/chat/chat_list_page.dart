import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacar/presentation/widgets/navbar.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';

import '../../widgets/ChatBlocList.dart';
import 'chat_page.dart';
import '../../widgets/ChatBlocProvider.dart';
import 'package:instacar/core/services/chat_service.dart';

class ChatListPage extends StatefulWidget {
  final String userId;
  const ChatListPage({super.key, required this.userId});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late ChatListBloc chatListBloc;
  int currentIndex = 3;

  @override
  void initState() {
    super.initState();
    chatListBloc = ChatListBloc();
    chatListBloc.add(LoadChats());
  }

  @override
  void dispose() {
    chatListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatListBloc,
      child: Scaffold(
        body: Column(
          children: [
            TopNavbar(
              title: "Chats",
              onSearchChanged: (value) {
                chatListBloc.add(SearchChats(value));
              },
            ),
            Expanded(
              child: BlocBuilder<ChatListBloc, ChatListState>(
                builder: (context, state) {
                  if (state is ChatListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatListLoaded) {
                    final chats = state.chats;
                    if (chats.isEmpty) {
                      return const Center(child: Text('Nenhum chat encontrado.'));
                    }
                    return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text(chat["initials"])),
                          title: Text(chat["name"]),
                          subtitle: Text(chat["LastMessage"]),
                          trailing: Text(chat["lastMessageTime"]),
                          onTap: () {
                            final history = chatListBloc.getChatHistory(chat["userId"]);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => ChatBloc(
                                    chatService: ChatService(),
                                    userId: widget.userId,
                                    receiverId: chat["userId"],
                                    initialMessages: history,
                                  ),
                                  child: ChatPage(
                                    userId: widget.userId,
                                    receiveName: chat["name"],
                                    receiverId: chat["userId"],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(selectedIndex: currentIndex),
      ),
    );
  }
}
