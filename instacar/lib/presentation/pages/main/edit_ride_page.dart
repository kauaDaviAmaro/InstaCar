import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditCaronaPage extends StatefulWidget {
  final Map<String, dynamic> carona;

  const EditCaronaPage({super.key, required this.carona});

  @override
  State<EditCaronaPage> createState() => _EditCaronaPageState();
}

class _EditCaronaPageState extends State<EditCaronaPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController fromController;
  late TextEditingController toController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController seatsController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    fromController = TextEditingController(text: widget.carona["from"]);
    toController = TextEditingController(text: widget.carona["to"]);
    dateController = TextEditingController(text: widget.carona["date"]);
    timeController = TextEditingController(text: widget.carona["time"]);
    seatsController = TextEditingController(text: widget.carona["seats"].toString());
  }

  Future<void> updateCarona() async {
    final url = Uri.parse('http://localhost:3000/api/caronas/${widget.carona["id"]}');
    final body = {
      "from": fromController.text,
      "to": toController.text,
      "date": dateController.text,
      "time": timeController.text,
      "seats": int.parse(seatsController.text),
    };

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true); // Retorna sucesso para página anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao atualizar carona: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro de conexão: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Carona")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: fromController, decoration: const InputDecoration(labelText: "Origem")),
              TextFormField(controller: toController, decoration: const InputDecoration(labelText: "Destino")),
              TextFormField(controller: dateController, decoration: const InputDecoration(labelText: "Data (YYYY-MM-DD)")),
              TextFormField(controller: timeController, decoration: const InputDecoration(labelText: "Hora")),
              TextFormField(controller: seatsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Vagas")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) updateCarona();
                },
                child: const Text("Salvar Alterações"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
