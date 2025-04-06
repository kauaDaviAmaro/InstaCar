import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  _SetPassword createState() => _SetPassword();
}

class _SetPassword extends State<SetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;  // Variável separada para o campo de confirmar senha
  bool _isLoading = false;
  bool _isSuccess = false;

  void _validatePassword() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        GoRouter.of(context).push('/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Insira uma nova senha", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Crie uma nova senha diferente das anteriores.", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 30),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirmar senha",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _validatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Atualizar senha", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),

          // Se o estado de sucesso for verdadeiro, mostrar a animação do Lottie
          if (_isSuccess)
            Positioned.fill(
              child: Container(
                color: Colors.white,  // Para escurecer o fundo
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/lottie/success.json', width: 150, repeat: false),
                      SizedBox(height: 10),
                      Text("Senha alterada com sucesso!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      SizedBox(height: 400),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
