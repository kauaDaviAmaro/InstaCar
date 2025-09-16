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

      // Ensure we scroll to bottom after initial load
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      print('Error initializing chat: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeSocket() async {
    // Use same base from AuthService
    final baseUrl = 'http://localhost:3000';
    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': widget.userId}
    });

    socket!.on('connect', (_) {
      print('Connected to server');
    });

    socket!.on('receiveMessage', (data) {
      if (!mounted) return;
      setState(() {
        messages.add(Message(
          senderId: data['senderId']?.toString() ?? '',
          receiverId: data['receiverId']?.toString() ?? '',
          message: data['message']?.toString() ?? '',
          timestamp: DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
        ));
      });
      _scrollToBottom();
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
            senderId: msg['senderId'].toString(),
            receiverId: widget.receiverId,
            message: msg['message'].toString(),
            timestamp: DateTime.tryParse(msg['createdAt']?.toString() ?? '') ?? DateTime.now(),
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
      });
      _scrollToBottom();

      try {
        // Send message via socket (real-time)
        socket?.emit('sendMessage', {
          'senderId': widget.userId,
          'receiverId': widget.receiverId,
          'message': message,
        });

        // Persist via REST as a fallback/consistency (optional but safer)
        await ChatService.sendMessage(widget.receiverId, message);
      } catch (e) {
        print('Error sending message: $e');
      }

      messageController.clear();
    }
  }

  @override
  void dispose() {
    socket?.disconnect();
    _scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    // Delay to wait for new items to render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
                      final isMe = msg.senderId == widget.userId;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.message,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTime(msg.timestamp),
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                            ],
                          ),
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

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
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
