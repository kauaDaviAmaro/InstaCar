import 'package:flutter/material.dart';
import 'package:instacar/core/models/RideCard.dart';
import 'package:instacar/core/models/RideModel.dart';
import 'package:instacar/core/services/ride_service.dart';
import 'package:instacar/core/services/user_service.dart';

class RideListWidget extends StatefulWidget {
  final String searchQuery;
  final List<String>? favoriteRideIds;
  final String? vehicleType;
  final String? gender;
  final int? spots;
  final String? sortOrder;
  final int? minAge;
  final int? maxAge;

  const RideListWidget({
    super.key,
    required this.searchQuery,
    this.favoriteRideIds,
    this.vehicleType,
    this.gender,
    this.spots,
    this.sortOrder,
    this.minAge,
    this.maxAge,
  });

  @override
  State<RideListWidget> createState() => _RideListWidgetState();
}

class _RideListWidgetState extends State<RideListWidget> {
  late Future<List<RideModel>> _futureRides;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _futureRides = RideService().fetchRides();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    try {
      final userId = await UserService.getCurrentUserId();
      if (mounted) {
        setState(() {
          _currentUserId = userId;
        });
      }
    } catch (e) {
      print('Error getting current user ID: $e');
    }
  }

  // Helper method to extract age from genderAge string
  int? _extractAgeFromGenderAge(String genderAge) {
    final regex = RegExp(r'\d+');
    final match = regex.firstMatch(genderAge);
    if (match != null) {
      return int.tryParse(match.group(0)!);
    }
    return null;
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

        // Filtro por favoritos, busca e outros critérios
        final filteredRides = rides.where((ride) {
          // Filtro para não mostrar a própria corrida do usuário
          if (_currentUserId != null && ride.motoristaId == _currentUserId) {
            return false;
          }

          // Filtro de busca
          final matchesSearch = ride.name.toLowerCase().contains(query) ||
              ride.from.toLowerCase().contains(query) ||
              ride.to.toLowerCase().contains(query);

          // Filtro por favoritos
          if (widget.favoriteRideIds != null) {
            if (!widget.favoriteRideIds!.contains(ride.id)) {
              return false;
            }
          }

          // Filtro por tipo de veículo
          if (widget.vehicleType != null && widget.vehicleType!.isNotEmpty) {
            if (ride.type.toLowerCase() != widget.vehicleType!.toLowerCase()) {
              return false;
            }
          }

          // Filtro por gênero
          if (widget.gender != null && widget.gender!.isNotEmpty) {
            if (!ride.genderAge.toLowerCase().contains(widget.gender!.toLowerCase())) {
              return false;
            }
          }

          // Filtro por vagas disponíveis
          if (widget.spots != null) {
            final availableSpots = ride.totalSpots - ride.takenSpots;
            if (availableSpots < widget.spots!) {
              return false;
            }
          }

          // Filtro por faixa etária (assumindo que genderAge contém idade)
          if (widget.minAge != null || widget.maxAge != null) {
            final ageMatch = _extractAgeFromGenderAge(ride.genderAge);
            if (ageMatch != null) {
              if (widget.minAge != null && ageMatch < widget.minAge!) {
                return false;
              }
              if (widget.maxAge != null && ageMatch > widget.maxAge!) {
                return false;
              }
            }
          }

          return matchesSearch;
        }).toList();

        // Ordenação
        if (widget.sortOrder != null) {
          if (widget.sortOrder == 'Mais recentes') {
            filteredRides.sort((a, b) => b.date.compareTo(a.date));
          } else if (widget.sortOrder == 'Mais antigos') {
            filteredRides.sort((a, b) => a.date.compareTo(b.date));
          }
        }

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
              motoristaId: ride.motoristaId,
            );
          },
        );
      },
    );
  }
}
