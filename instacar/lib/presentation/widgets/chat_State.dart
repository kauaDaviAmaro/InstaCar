part of 'ChatBlocProvider.dart';

abstract class ChatState {
  List<Message> get messages;
}

class ChatInitial extends ChatState {
  final List<Message> messages;
  ChatInitial({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  ChatLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}
