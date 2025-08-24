import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> registerUser() async {
    final url = Uri.parse('http://localhost:3000/api/users/register');

    final body = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'birthDate': birthDateController.text.trim(),
      'phone': phoneController.text.trim(),
      'cep': cepController.text.trim(),
      'number': numberController.text.trim(),
      'password': passwordController.text.trim(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        // Cadastro bem-sucedido
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        GoRouter.of(context).go('/login');
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro: ${responseData['message'] ?? 'Falha no cadastro'}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro de rede: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text('Voltar'),
            floating: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => GoRouter.of(context).go('/login'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cadastre-se",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Crie uma conta para continuar!",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      'Nome',
                      nameController,
                      hintText: 'Digite seu nome completo',
                    ),
                    _buildTextField(
                      'Email',
                      emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Digite seu email',
                    ),
                    _buildDateField('Data de nascimento', birthDateController),
                    _buildTextField(
                      'Celular',
                      phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: 'Digite seu número de celular',
                      inputFormatters: [MaskedInputFormatter('## #####-####')],
                    ),
                    _buildTextField(
                      'CEP',
                      cepController,
                      keyboardType: TextInputType.number,
                      hintText: 'Digite seu CEP',
                      inputFormatters: [MaskedInputFormatter('#####-###')],
                    ),
                    _buildTextField(
                      'Número',
                      numberController,
                      keyboardType: TextInputType.number,
                      hintText: 'Digite o número da residência',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    _buildPasswordField(
                      'Senha',
                      passwordController,
                      isConfirm: false,
                      hintText: 'Digite sua senha',
                    ),
                    _buildPasswordField(
                      'Confirmar senha',
                      confirmPasswordController,
                      isConfirm: true,
                      hintText: 'Confirme sua senha',
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_formKey.currentState!.validate()) {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('As senhas não coincidem'),
                                  ),
                                );
                                return;
                              }
                              await registerUser();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
            ),
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'DD/MM/AAAA',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                controller.text = DateFormat('dd/MM/yyyy').format(picked);
              }
            },
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller, {
    required bool isConfirm,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          TextFormField(
            controller: controller,
            obscureText: isConfirm ? _obscureConfirmPassword : _obscurePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
              suffixIcon: IconButton(
                icon: Icon(
                  isConfirm
                      ? (_obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility)
                      : (_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    } else {
                      _obscurePassword = !_obscurePassword;
                    }
                  });
                },
              ),
            ),
            validator:
                (value) =>
                    (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
          ),
        ],
      ),
    );
  }
}
