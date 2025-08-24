import 'package:flutter/material.dart';
import 'package:instacar/core/models/RideCard.dart';
import 'package:instacar/core/models/RideModel.dart';
import 'package:instacar/core/services/ride_service.dart';

class RideListWidget extends StatefulWidget {
  final String searchQuery;
  final List<String>? favoriteRideIds;

  const RideListWidget({
    super.key,
    required this.searchQuery,
    this.favoriteRideIds,
  });

  @override
  State<RideListWidget> createState() => _RideListWidgetState();
}

class _RideListWidgetState extends State<RideListWidget> {
  late Future<List<RideModel>> _futureRides;

  @override
  void initState() {
    super.initState();
    _futureRides = RideService().fetchRides();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RideModel>>(
      future: _futureRides,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro ao carregar caronas: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        final rides = snapshot.data!;
        final query = widget.searchQuery.toLowerCase();

        // Filtro por favoritos e busca
        final filteredRides = rides.where((ride) {
          final matchesSearch = ride.name.toLowerCase().contains(query) ||
              ride.from.toLowerCase().contains(query) ||
              ride.to.toLowerCase().contains(query);

          // Se foi fornecida a lista de favoritos, filtra por ela
          if (widget.favoriteRideIds != null) {
            return widget.favoriteRideIds!.contains(ride.id) && matchesSearch;
          }

          return matchesSearch;
        }).toList();

        if (filteredRides.isEmpty) {
          return const Center(
            child: Text(
              "Nenhuma carona encontrada.",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredRides.length,
          itemBuilder: (context, index) {
            final ride = filteredRides[index];
            return RideCard(
              id: ride.id,
              name: ride.name,
              genderAge: ride.genderAge,
              date: ride.date,
              from: ride.from,
              to: ride.to,
              type: ride.type,
              model: ride.model,
              color: ride.color,
              plate: ride.plate,
              totalSpots: ride.totalSpots,
              takenSpots: ride.takenSpots,
              observation: ride.observation,
            );
          },
        );
      },
    );
  }
}
