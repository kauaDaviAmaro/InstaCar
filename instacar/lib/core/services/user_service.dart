class UserService {

  // Get user by ID
  static Future<Map<String, dynamic>> getUserById(String userId) async {
    // Mock data for users
    await Future.delayed(Duration(milliseconds: 200)); // Simulate network delay
    
    final mockUsers = {
      'user_1': {
        'id': 'user_1',
        'name': 'Maria Silva',
        'email': 'maria.silva@email.com',
        'phone': '(11) 99999-1111',
        'createdAt': DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
      },
      'user_2': {
        'id': 'user_2',
        'name': 'João Santos',
        'email': 'joao.santos@email.com',
        'phone': '(11) 99999-2222',
        'createdAt': DateTime.now().subtract(Duration(days: 25)).toIso8601String(),
      },
      'user_3': {
        'id': 'user_3',
        'name': 'Ana Costa',
        'email': 'ana.costa@email.com',
        'phone': '(11) 99999-3333',
        'createdAt': DateTime.now().subtract(Duration(days: 20)).toIso8601String(),
      },
      'user_4': {
        'id': 'user_4',
        'name': 'Carlos Oliveira',
        'email': 'carlos.oliveira@email.com',
        'phone': '(11) 99999-4444',
        'createdAt': DateTime.now().subtract(Duration(days: 15)).toIso8601String(),
      },
      'user_5': {
        'id': 'user_5',
        'name': 'Fernanda Lima',
        'email': 'fernanda.lima@email.com',
        'phone': '(11) 99999-5555',
        'createdAt': DateTime.now().subtract(Duration(days: 10)).toIso8601String(),
      },
    };
    
    if (mockUsers.containsKey(userId)) {
      return mockUsers[userId]!;
    } else {
      throw Exception('User not found: $userId');
    }
  }

  // Get current user profile
  static Future<Map<String, dynamic>> getCurrentUser() async {
    // Mock current user data
    await Future.delayed(Duration(milliseconds: 200)); // Simulate network delay
    
    return {
      'id': 'current_user',
      'name': 'Usuário Atual',
      'email': 'usuario@email.com',
      'phone': '(11) 99999-0000',
      'createdAt': DateTime.now().subtract(Duration(days: 60)).toIso8601String(),
    };
  }
}
