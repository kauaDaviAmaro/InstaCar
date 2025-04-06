import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:go_router/go_router.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  _CodePage createState() => _CodePage();
}

class _CodePage extends State<CodePage> {
  final TextEditingController _pinController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Verifique seu email",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Entre com os 5 dígitos que enviamos para (email)",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            Center(
              child: Pinput(
                length: 5,
                controller: _pinController,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/reset');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Verificar código", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Não recebeu o email ainda? Reenviar email",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}