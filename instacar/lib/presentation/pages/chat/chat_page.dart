import 'package:flutter/material.dart';
import 'package:instacar/core/models/message_model.dart';
import 'package:instacar/core/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String receiveName;
  final String receiverId;

  const ChatPage({super.key, required this.userId, required this.receiveName, required this.receiverId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();
  final TextEditingController messageController = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    chatService.connect(widget.userId);

    chatService.socket!.on('receiveMessage', (data) {
      setState(() {
        messages.add(Message.fromJson(data));
      });
    });
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      String message = messageController.text.trim();
      chatService.sendMessage(widget.userId, widget.receiverId, message);
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
      messageController.clear();
    }
  }

  @override
  void dispose() {
    chatService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Chat com ${widget.receiveName}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg.senderId == widget.userId
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment:
                        msg.senderId == widget.userId
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              msg.senderId == widget.userId
                                  ? Colors.blue
                                  : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg.message,
                          style: TextStyle(
                            color:
                                msg.senderId == widget.userId
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              msg.senderId == widget.userId ? "Você" : "Outro",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      "${messageController.text.length}/200",
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            messageController.text.length >= 200
                                ? Colors.red
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 100),
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Digite sua mensagem...",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.multiline,
                          onChanged: (text) {
                            if (text.length > 200) {
                              messageController.text = text.substring(0, 200);
                              messageController
                                  .selection = TextSelection.fromPosition(
                                TextPosition(
                                  offset: messageController.text.length,
                                ),
                              );
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
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
