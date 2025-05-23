part of 'ChatBlocList.dart';

abstract class ChatListEvent {}

class LoadChats extends ChatListEvent {}

class SearchChats extends ChatListEvent {
  final String query;
  SearchChats(this.query);
}
