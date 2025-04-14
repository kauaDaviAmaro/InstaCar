import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;

  void connect(String userId) {
    socket = IO.io('http://seu-servidor.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      print('✅ Conectado ao WebSocket');
      socket!.emit('joinUser', userId);
    });

    socket!.on('receiveMessage', (data) {
      print('📩 Nova mensagem: ${data['message']}');
    });

    socket!.onDisconnect((_) => print('❌ Desconectado'));
  }

  void sendMessage(String senderId, String receiverId, String message) {
    if (socket != null) {
      socket!.emit('sendMessage', {
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
      });
    }
  }

  void disconnect() {
    socket!.disconnect();
  }
}
