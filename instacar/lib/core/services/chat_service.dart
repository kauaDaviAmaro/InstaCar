class ChatService {

  // Get or create conversation between two users
  static Future<Map<String, dynamic>> getOrCreateConversation(String user2Id) async {
    // Mock conversation creation
    await Future.delayed(Duration(milliseconds: 300)); // Simulate network delay
    
    return {
      'id': 'conv_$user2Id',
      'user1Id': 'current_user',
      'user2Id': user2Id,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'Messages': [],
    };
  }

  // Send a message
  static Future<Map<String, dynamic>> sendMessage(String receiverId, String message) async {
    // Mock message sending
    await Future.delayed(Duration(milliseconds: 400)); // Simulate network delay
    
    return {
      'id': 'msg_${DateTime.now().millisecondsSinceEpoch}',
      'message': message,
      'senderId': 'current_user',
      'receiverId': receiverId,
      'createdAt': DateTime.now().toIso8601String(),
      'conversationId': 'conv_$receiverId',
    };
  }

  // Get user's conversations
  static Future<List<dynamic>> getUserConversations() async {
    // Mock data for conversations
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    
    return [
      {
        'id': 'conv_1',
        'user1Id': 'current_user',
        'user2Id': 'user_1',
        'Messages': [
          {
            'id': 'msg_1',
            'message': 'Oi! Ainda tem vaga na carona para o centro?',
            'createdAt': DateTime.now().subtract(Duration(hours: 2)).toIso8601String(),
            'senderId': 'user_1',
          }
        ],
        'createdAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
        'updatedAt': DateTime.now().subtract(Duration(hours: 2)).toIso8601String(),
      },
      {
        'id': 'conv_2',
        'user1Id': 'current_user',
        'user2Id': 'user_2',
        'Messages': [
          {
            'id': 'msg_2',
            'message': 'Perfeito! Te encontro na estação às 8h',
            'createdAt': DateTime.now().subtract(Duration(minutes: 30)).toIso8601String(),
            'senderId': 'user_2',
          }
        ],
        'createdAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
        'updatedAt': DateTime.now().subtract(Duration(minutes: 30)).toIso8601String(),
      },
      {
        'id': 'conv_3',
        'user1Id': 'current_user',
        'user2Id': 'user_3',
        'Messages': [
          {
            'id': 'msg_3',
            'message': 'Obrigado pela carona hoje! Foi muito bom conversar',
            'createdAt': DateTime.now().subtract(Duration(hours: 5)).toIso8601String(),
            'senderId': 'user_3',
          }
        ],
        'createdAt': DateTime.now().subtract(Duration(days: 3)).toIso8601String(),
        'updatedAt': DateTime.now().subtract(Duration(hours: 5)).toIso8601String(),
      },
      {
        'id': 'conv_4',
        'user1Id': 'current_user',
        'user2Id': 'user_4',
        'Messages': [
          {
            'id': 'msg_4',
            'message': 'Amanhã posso te buscar na faculdade?',
            'createdAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            'senderId': 'user_4',
          }
        ],
        'createdAt': DateTime.now().subtract(Duration(days: 4)).toIso8601String(),
        'updatedAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
      },
      {
        'id': 'conv_5',
        'user1Id': 'current_user',
        'user2Id': 'user_5',
        'Messages': [
          {
            'id': 'msg_5',
            'message': 'Vamos combinar a carona da próxima semana',
            'createdAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
            'senderId': 'user_5',
          }
        ],
        'createdAt': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
        'updatedAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
      },
    ];
  }

  // Get messages from a conversation
  static Future<List<dynamic>> getConversationMessages(String conversationId) async {
    // Mock data for conversation messages
    await Future.delayed(Duration(milliseconds: 300)); // Simulate network delay
    
    final mockMessages = {
      'conv_1': [
        {
          'id': 'msg_1_1',
          'message': 'Oi! Ainda tem vaga na carona para o centro?',
          'createdAt': DateTime.now().subtract(Duration(hours: 2)).toIso8601String(),
          'senderId': 'user_1',
        },
        {
          'id': 'msg_1_2',
          'message': 'Sim! Tem sim, pode vir',
          'createdAt': DateTime.now().subtract(Duration(hours: 1, minutes: 45)).toIso8601String(),
          'senderId': 'current_user',
        },
        {
          'id': 'msg_1_3',
          'message': 'Perfeito! Que horas você sai?',
          'createdAt': DateTime.now().subtract(Duration(hours: 1, minutes: 30)).toIso8601String(),
          'senderId': 'user_1',
        },
      ],
      'conv_2': [
        {
          'id': 'msg_2_1',
          'message': 'Perfeito! Te encontro na estação às 8h',
          'createdAt': DateTime.now().subtract(Duration(minutes: 30)).toIso8601String(),
          'senderId': 'user_2',
        },
        {
          'id': 'msg_2_2',
          'message': 'Combinado! Até lá',
          'createdAt': DateTime.now().subtract(Duration(minutes: 25)).toIso8601String(),
          'senderId': 'current_user',
        },
      ],
      'conv_3': [
        {
          'id': 'msg_3_1',
          'message': 'Obrigado pela carona hoje! Foi muito bom conversar',
          'createdAt': DateTime.now().subtract(Duration(hours: 5)).toIso8601String(),
          'senderId': 'user_3',
        },
        {
          'id': 'msg_3_2',
          'message': 'De nada! Foi um prazer te conhecer',
          'createdAt': DateTime.now().subtract(Duration(hours: 4, minutes: 45)).toIso8601String(),
          'senderId': 'current_user',
        },
      ],
      'conv_4': [
        {
          'id': 'msg_4_1',
          'message': 'Amanhã posso te buscar na faculdade?',
          'createdAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
          'senderId': 'user_4',
        },
      ],
      'conv_5': [
        {
          'id': 'msg_5_1',
          'message': 'Vamos combinar a carona da próxima semana',
          'createdAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
          'senderId': 'user_5',
        },
      ],
    };
    
    return mockMessages[conversationId] ?? [];
  }
}