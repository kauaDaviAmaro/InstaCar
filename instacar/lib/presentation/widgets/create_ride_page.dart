import 'package:flutter/material.dart';

class CreateRidePage extends StatefulWidget {
  const CreateRidePage({super.key});

  @override
  State<CreateRidePage> createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  int _seatCount = 1;

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    _vehicleModelController.dispose();
    _vehicleColorController.dispose();
    _licensePlateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar nova carona')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Crie sua carona, se atente as informações obrigatórias.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Endereço de saída
              const Text(
                'Endereço de Saída *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _departureController,
                decoration: const InputDecoration(
                  hintText: 'Adicione endereço',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço de saída';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Endereço de chegada
              const Text(
                'Endereço de Final *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  hintText: 'Adicione endereço',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço de destino';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Modelo de veículo
              const Text(
                'Modelo do veículo *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _vehicleModelController,
                decoration: const InputDecoration(
                  hintText: 'Adicione modelo do veículo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o modelo do veículo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Cor do Veículo
              const Text(
                'Cor do veículo *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _vehicleColorController,
                decoration: const InputDecoration(
                  hintText: 'Adicione a cor do veículo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a cor do veículo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Placa do Veículo
              const Text(
                'Placa do veículo *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _licensePlateController,
                decoration: const InputDecoration(
                  hintText: 'Adicione a placa do carro',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a placa do veículo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Contador de vagas
              const Text(
                'Número de vagas no carro *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ), // Changed to blue border
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      color: Colors.blue, // Blue icon
                      onPressed: () {
                        setState(() {
                          if (_seatCount > 0) _seatCount--;
                        });
                      },
                    ),
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '$_seatCount',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Blue text
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.blue, // Blue icon
                      onPressed: () {
                        setState(() {
                          _seatCount++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Obervações
              const Text(
                'Observações',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Adicione suas observações',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button (Confirm)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Carona criada com sucesso!'),
                        ),
                      );
                      print({
                        'departure': _departureController.text,
                        'destination': _destinationController.text,
                        'vehicleModel': _vehicleModelController.text,
                        'vehicleColor': _vehicleColorController.text,
                        'licensePlate': _licensePlateController.text,
                        'seats': _seatCount,
                        'notes': _notesController.text,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                    ), // 18 vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 8 border radius
                    ),
                  ),
                  child: const Text('Confirmar'),
                ),
              ),
              const SizedBox(height: 16),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                    ), // 18 vertical padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 8 border radius
                    ),
                  ),
                  child: const Text('Cancelar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
