import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instacar/core/models/message_model.dart';
import 'package:instacar/core/services/chat_service.dart';

part 'chat_event.dart';
part 'chat_State.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;
  final String userId;
  final String receiverId;

  ChatBloc({
    required this.chatService,
    required this.userId,
    required this.receiverId,
    List<Message> initialMessages = const [],
  }) : super(ChatInitial(messages: initialMessages)) {
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);

    chatService.connect(userId);

    chatService.socket!.on('receiveMessage', (data) {
      add(ReceiveMessage(Message.fromJson(data)));
    });
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    if (state is ChatLoaded || state is ChatInitial) {
      final currentMessages = state.messages;
      final newMessage = Message(
        senderId: userId,
        receiverId: receiverId,
        message: event.message,
        timestamp: DateTime.now(),
      );

      chatService.sendMessage(userId, receiverId, event.message);

      final updatedMessages = List<Message>.from(currentMessages)..add(newMessage);

      emit(ChatLoaded(messages: updatedMessages));
    }
  }

  void _onReceiveMessage(ReceiveMessage event, Emitter<ChatState> emit) {
    if (state is ChatLoaded || state is ChatInitial) {
      final currentMessages = state.messages;
      final updatedMessages = List<Message>.from(currentMessages)..add(event.message);
      emit(ChatLoaded(messages: updatedMessages));
    }
  }

  @override
  Future<void> close() {
    chatService.disconnect();
    return super.close();
  }
}
