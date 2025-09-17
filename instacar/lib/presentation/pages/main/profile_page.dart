import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instacar/core/services/auth_service.dart' as core_auth;
import 'package:instacar/core/services/user_service.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Função para extrair as iniciais do nome
  String _getInitials(String name) {
    if (name.isEmpty) return "U";
    
    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      return (words[0][0] + words[words.length - 1][0]).toUpperCase();
    }
  }

  // Função para gerar uma cor baseada no nome
  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
    ];
    
    int hash = name.hashCode;
    return colors[hash.abs() % colors.length];
  }

  void logout(BuildContext context) {
    core_auth.AuthService.logout();
    GoRouter.of(context).go('/login');
  }

  void navigateToEditProfile(BuildContext context) {
    GoRouter.of(context).go('/edit-profile');
  }

  void navigateToTerms(BuildContext context) {
    GoRouter.of(context).push('/terms');
  }

  void navigateToContact(BuildContext context) {
    GoRouter.of(context).push('/contact');
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configurações",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          FutureBuilder<Map<String, dynamic>>(
            future: UserService.getCurrentUser(),
            builder: (context, snapshot) {
              String initials = "U";
              Color avatarColor = Colors.blue;
              
              if (snapshot.hasData && snapshot.data!['name'] != null) {
                final name = snapshot.data!['name'] as String;
                initials = _getInitials(name);
                avatarColor = _getAvatarColor(name);
              }
              
              return CircleAvatar(
                radius: 50,
                backgroundColor: avatarColor,
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          FutureBuilder<Map<String, dynamic>>(
            future: UserService.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  "Carregando...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              } else if (snapshot.hasError) {
                return const Text(
                  "Bem-vindo, Usuário",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              } else if (snapshot.hasData) {
                final userData = snapshot.data!;
                final userName = userData['name'] ?? 'Usuário';
                return Text(
                  "Bem-vindo, $userName",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              } else {
                return const Text(
                  "Bem-vindo, Usuário",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              }
            },
          ),
          const SizedBox(height: 30),
          _buildMenuItem(
            icon: Icons.person,
            text: "Editar Perfil",
            onTap: () => navigateToEditProfile(context),
          ),
          _buildMenuItem(
            icon: Icons.description,
            text: "Termos de serviço",
            onTap: () => navigateToTerms(context),
          ),
          _buildMenuItem(
            icon: Icons.headphones,
            text: "Fale conosco",
            onTap: () => navigateToContact(context),
          ),
          _buildMenuItem(
            icon: Icons.logout,
            text: "Logout",
            isLogout: true,
            onTap: () => logout(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: currentIndex),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 24, color: isLogout ? Colors.red : Colors.black),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: isLogout ? Colors.red : Colors.black,
                ),
              ),
            ),

          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}
