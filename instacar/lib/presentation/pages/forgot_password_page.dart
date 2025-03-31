import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/instacar.png', height: 110),
            SizedBox(height: 16),
            SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Esqueceu sua senha",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Por favor insira seu email para alterar sua senha",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Seu email",
                hintText: "Digite seu email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/code');
              },
              child: Text("Redefinir senha", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blue,

              ),
            ),
          ],
        ),
      ),
    );
  }
}