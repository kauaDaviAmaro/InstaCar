import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;

  void connect(String userId) {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();
    socket!.onConnect((_) {
      print('Conectado ao servidor de chat');
      socket!.emit('register', userId);
    });

    socket!.onDisconnect((_) {
      print('Desconectado do chat');
    });
  }

  void sendMessage(String senderId, String receiverId, String message) {
    socket?.emit('sendMessage', {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
    });
  }

  void disconnect() {
    socket?.disconnect();
  }
}
