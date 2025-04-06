import 'package:flutter/material.dart';
import 'package:instacar/core/models/RideCard.dart';

class RideListWidget extends StatefulWidget {
  final String searchQuery;

  const RideListWidget({super.key, required this.searchQuery});

  @override
  State<RideListWidget> createState() => _RideListWidgetState();
}

class _RideListWidgetState extends State<RideListWidget> {
  final List<Map<String, dynamic>> rides = [
    {
      "name": "Leonardo Nakamura",
      "genderAge": "Masc. \\ 27 anos",
      "date": "17/03/2025",
      "from": "Avenida República",
      "to": "Rua São Luiz",
      "type": "Carro",
      "model": "Yaris Sedan",
      "color": "Branco",
      "plate": "DKA5675",
      "totalSpots": 6,
      "takenSpots": 4,
      "observation": "Lorem ipsum sadsa sdcxs",
    },
    {
      "name": "Maria Oliveira",
      "genderAge": "Feminino \\ 32 anos",
      "date": "18/03/2025",
      "from": "Rua das Flores",
      "to": "Praça da Liberdade",
      "type": "Carro",
      "model": "Civic",
      "color": "Preto",
      "plate": "ABC1234",
      "totalSpots": 5,
      "takenSpots": 2,
      "observation": "Viagem tranquila, sem paradas.",
    },
    {
      "name": "Carlos Silva",
      "genderAge": "Masculino \\ 45 anos",
      "date": "19/03/2025",
      "from": "Avenida Paulista",
      "to": "Shopping Center",
      "type": "Carro",
      "model": "Fusca",
      "color": "Azul",
      "plate": "XYZ9876",
      "totalSpots": 4,
      "takenSpots": 1,
      "observation": "Levar algumas compras.",
    },
    {
      "name": "Ana Costa",
      "genderAge": "Feminino \\ 29 anos",
      "date": "20/03/2025",
      "from": "Rua da Consolação",
      "to": "Teatro Municipal",
      "type": "Carro",
      "model": "Onix",
      "color": "Vermelho",
      "plate": "LMN4567",
      "totalSpots": 5,
      "takenSpots": 3,
      "observation": "Evento cultural, chegar cedo.",
    },
    {
      "name": "Roberto Almeida",
      "genderAge": "Masculino \\ 38 anos",
      "date": "21/03/2025",
      "from": "Rua dos Três Irmãos",
      "to": "Estádio Municipal",
      "type": "Carro",
      "model": "Palio",
      "color": "Cinza",
      "plate": "QWE1234",
      "totalSpots": 6,
      "takenSpots": 5,
      "observation": "Jogo de futebol, muita animação!",
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredRides =
        rides.where((ride) {
          final query = widget.searchQuery.toLowerCase();
          return ride['name'].toLowerCase().contains(query) ||
              ride['from'].toLowerCase().contains(query) ||
              ride['to'].toLowerCase().contains(query);
        }).toList();

    return ListView.builder(
      itemCount: filteredRides.length,
      itemBuilder: (context, index) {
        final ride = filteredRides[index];
        return RideCard(
          name: ride['name'],
          genderAge: ride['genderAge'],
          date: ride['date'],
          from: ride['from'],
          to: ride['to'],
          type: ride['type'],
          model: ride['model'],
          color: ride['color'],
          plate: ride['plate'],
          totalSpots: ride['totalSpots'],
          takenSpots: ride['takenSpots'],
          observation: ride['observation'],
        );
      },
    );
  }
}
