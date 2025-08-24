import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String receiveName; // This is the bot's name
  final String receiverId;

  const ChatPage({
    super.key,
    required this.userId,
    required this.receiveName,
    required this.receiverId,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();
  String? _userName; // To store the user's name

  void _generateAutoReply(String userMessage) {
    // Extract user's name if provided
    if (_userName == null &&
        (userMessage.toLowerCase().contains('meu nome é') ||
            userMessage.toLowerCase().contains('eu sou'))) {
      final nameStart =
          userMessage.toLowerCase().contains('meu nome é')
              ? userMessage.toLowerCase().indexOf('meu nome é') +
                  'meu nome é'.length
              : userMessage.toLowerCase().indexOf('eu sou') + 'eu sou'.length;

      _userName = userMessage.substring(nameStart).trim();
      if (_userName!.endsWith('.')) {
        _userName = _userName!.substring(0, _userName!.length - 1);
      }
    }

    String reply = '';

    if (userMessage.toLowerCase().contains('oi') ||
        userMessage.toLowerCase().contains('olá') ||
        userMessage.toLowerCase().contains('ola')) {
      reply =
          _userName != null
              ? 'Olá $_userName! Eu sou ${widget.receiveName}. Como posso te ajudar hoje?'
              : 'Olá! Eu sou ${widget.receiveName}. Qual é o seu nome?';
    } else if (userMessage.toLowerCase().contains('tudo bem') ||
        userMessage.toLowerCase().contains('como vai')) {
      reply =
          _userName != null
              ? 'Estou ótimo, obrigado por perguntar $_userName! Eu sou ${widget.receiveName}. E com você?'
              : 'Estou ótimo! Eu sou ${widget.receiveName}. Qual é o seu nome?';
    } else if (userMessage.toLowerCase().contains('horário') ||
        userMessage.toLowerCase().contains('hora')) {
      reply =
          'Agora são ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';
    } else if (userMessage.toLowerCase().contains('carona') ||
        userMessage.toLowerCase().contains('viagem')) {
      reply =
          'Eu sou ${widget.receiveName}, posso te ajudar com informações sobre caronas. Você quer ofertar ou solicitar uma carona?';
    } else if (userMessage.toLowerCase().contains('obrigado') ||
        userMessage.toLowerCase().contains('obrigada')) {
      reply =
          'De nada${_userName != null ? ' $_userName' : ''}! Eu sou ${widget.receiveName}, estou aqui para ajudar. 😊';
    } else if (userMessage.toLowerCase().contains('ajuda')) {
      reply =
          'Claro${_userName != null ? ' $_userName' : ''}! Eu sou ${widget.receiveName}, posso te ajudar com:\n'
          '- Informações sobre caronas\n'
          '- Configurações da sua conta\n'
          '- Problemas técnicos\n'
          'O que você precisa?';
    } else if (_userName == null) {
      reply =
          'Eu sou ${widget.receiveName}. Antes de continuarmos, qual é o seu nome?';
    } else {
      reply =
          'Desculpe $_userName, não entendi. Eu sou ${widget.receiveName}, pode reformular sua pergunta?';
    }

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add(
          Message(
            senderId: widget.receiverId,
            receiverId: widget.userId,
            message: reply,
            timestamp: DateTime.now(),
          ),
        );
        _scrollToBottom();
      });
    });
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      String message = messageController.text.trim();

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

      _generateAutoReply(message);
      messageController.clear();
    }
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Initial greeting from the bot
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add(
          Message(
            senderId: widget.receiverId,
            receiverId: widget.userId,
            message: 'Olá! Eu sou ${widget.receiveName}. Qual é o seu nome?',
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          _userName != null
              ? "Conversa com $_userName"
              : "Conversa com ${widget.receiveName}",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              msg.senderId == widget.userId
                                  ? Colors.blue
                                  : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
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
