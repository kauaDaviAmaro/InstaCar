part of 'ChatBlocProvider.dart';

abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
  SendMessage(this.message);
}

class ReceiveMessage extends ChatEvent {
  final Message message;
  ReceiveMessage(this.message);
}
