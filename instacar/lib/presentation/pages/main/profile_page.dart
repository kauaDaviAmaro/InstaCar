import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';
import 'edit_profile_page.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void logout(BuildContext context) {
    GoRouter.of(context).go('/login');
  }

  void navigateToEditProfile(BuildContext context) {
    GoRouter.of(context).go('/edit-profile');
  }

  void navigateToTerms(BuildContext context) {
    GoRouter.of(context).go('/terms');
  }

  void navigateToContact(BuildContext context) {
    GoRouter.of(context).go('/contact');
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
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 60, color: Colors.blue),
              ),
              GestureDetector(
                onTap: () => navigateToEditProfile(context),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Lucas Scott",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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