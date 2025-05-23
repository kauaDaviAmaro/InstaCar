import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instacar/core/models/message_model.dart';
import '../../core/app_router.dart';

part 'chat_list_event.dart';
part 'chat_list_State.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListInitial()) {
    on<LoadChats>(_onLoadChats);
    on<SearchChats>(_onSearchChats);
  }

  List<Map<String, dynamic>> _allChats = [];

  // Histórico mockado por usuárioId
  final Map<String, List<Message>> chatHistories = {
    "2": [
      Message(senderId: "2", receiverId: "1", message: "Oi! Como você está?", timestamp: DateTime.now().subtract(Duration(minutes: 15))),
      Message(senderId: "1", receiverId: "2", message: "Tudo ótimo, e você?", timestamp: DateTime.now().subtract(Duration(minutes: 10))),
    ],
    "3": [
      Message(senderId: "3", receiverId: "1", message: "Vamos nos encontrar?", timestamp: DateTime.now().subtract(Duration(hours: 1))),
      Message(senderId: "1", receiverId: "3", message: "Claro, onde?", timestamp: DateTime.now().subtract(Duration(minutes: 50))),
    ],
  };

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatListState> emit) async {
    emit(ChatListLoading());
    await Future.delayed(Duration(seconds: 1));

    _allChats = [
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

    emit(ChatListLoaded(chats: _allChats));
  }

  void _onSearchChats(SearchChats event, Emitter<ChatListState> emit) {
    final filtered = _allChats.where((chat) {
      return chat["name"].toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(ChatListLoaded(chats: filtered));
  }

  List<Message> getChatHistory(String userId) {
    return chatHistories[userId] ?? [];
  }
}
