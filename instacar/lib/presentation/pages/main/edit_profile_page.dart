import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _mostrarSenha = false;
  bool _mostrarConfirmaSenha = false;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.grey),
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _dataNascimentoController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  void _toggleMostrarSenha() {
    setState(() {
      _mostrarSenha = !_mostrarSenha;
    });
  }

  void _toggleMostrarConfirmaSenha() {
    setState(() {
      _mostrarConfirmaSenha = !_mostrarConfirmaSenha;
    });
  }

  void _editarInformacoes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informações atualizadas com sucesso!')),
    );

    Future.delayed(const Duration(seconds: 1), () {
      GoRouter.of(context).go('/profile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        title: const Text(
          'Perfil do Usuário',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Edite suas informações de usuário:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome completo',
                hintText: 'Insira seu nome',
                border: border,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Insira seu email',
                border: border,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(
                labelText: 'Data de nascimento',
                hintText: 'DD/MM/AAAA',
                suffixIcon: const Icon(Icons.calendar_today),
                border: border,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Número de celular',
                hintText: '(DDD) xxxxx-xxxx',
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('(🇧🇷)', style: TextStyle(fontSize: 16)),
                ),
                border: border,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: !_mostrarSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Insira sua senha',
                suffixIcon: IconButton(
                  icon: Icon(_mostrarSenha ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggleMostrarSenha,
                ),
                border: border,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmaSenhaController,
              obscureText: !_mostrarConfirmaSenha,
              decoration: InputDecoration(
                labelText: 'Confirmar senha',
                hintText: 'Confirme sua senha',
                suffixIcon: IconButton(
                  icon: Icon(_mostrarConfirmaSenha ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggleMostrarConfirmaSenha,
                ),
                border: border,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _editarInformacoes,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color(0xFFD0DBFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Editar informações',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

