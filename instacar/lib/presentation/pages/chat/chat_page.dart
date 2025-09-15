import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:instacar/core/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String receiveName;
  final String receiverId;
  final String? conversationId;

  const ChatPage({
    super.key,
    required this.userId,
    required this.receiveName,
    required this.receiverId,
    this.conversationId,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();
  IO.Socket? socket;
  String? conversationId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() async {
    try {
      // Get or create conversation
      if (widget.conversationId != null) {
        conversationId = widget.conversationId;
      } else {
        final conversation = await ChatService.getOrCreateConversation(widget.receiverId);
        conversationId = conversation['id'].toString();
      }

      // Load existing messages
      await _loadMessages();

      // Initialize socket connection
      _initializeSocket();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error initializing chat: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeSocket() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': widget.userId}
    });

    socket!.on('connect', (_) {
      print('Connected to server');
    });

    socket!.on('receiveMessage', (data) {
      setState(() {
        messages.add(Message(
          senderId: data['senderId'],
          receiverId: data['receiverId'],
          message: data['message'],
          timestamp: DateTime.parse(data['createdAt']),
        ));
        _scrollToBottom();
      });
    });

    socket!.on('disconnect', (_) {
      print('Disconnected from server');
    });
  }

  Future<void> _loadMessages() async {
    if (conversationId != null) {
      try {
        final messagesData = await ChatService.getConversationMessages(conversationId!);
        setState(() {
          messages = messagesData.map((msg) => Message(
            senderId: msg['senderId'],
            receiverId: widget.receiverId,
            message: msg['message'],
            timestamp: DateTime.parse(msg['createdAt']),
          )).toList();
        });
      } catch (e) {
        print('Error loading messages: $e');
      }
    }
  }

  void sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      String message = messageController.text.trim();

      // Add message to UI immediately
      setState(() {
        messages.add(
          Message(
            senderId: widget.userId,
            receiverId: widget.receiverId,
            message: message,
            timestamp: DateTime.now(),
          ),
        );
        _scrollToBottom();
      });

      // Send message via socket
      socket?.emit('sendMessage', {
        'senderId': widget.userId,
        'receiverId': widget.receiverId,
        'message': message,
      });

      messageController.clear();
    }
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Conversa com ${widget.receiveName}",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return Align(
                        alignment: msg.senderId == widget.userId
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: msg.senderId == widget.userId
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: msg.senderId == widget.userId
                                    ? Colors.blue
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                msg.message,
                                style: TextStyle(
                                  color: msg.senderId == widget.userId
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')} - ${msg.senderId == widget.userId ? "Você" : widget.receiveName}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Digite sua mensagem...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            color: Colors.blue,
                            onPressed: sendMessage,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
}
