part of 'ChatBlocList.dart';

abstract class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<Map<String, dynamic>> chats;
  ChatListLoaded({required this.chats});
}
