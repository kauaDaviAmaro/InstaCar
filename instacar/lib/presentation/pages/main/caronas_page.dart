import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instacar/presentation/pages/main/edit_ride_page.dart';
import 'dart:convert';

import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';
import 'package:instacar/presentation/widgets/create_ride_page.dart';
import 'package:instacar/presentation/widgets/navbar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:instacar/presentation/pages/chat/chat_page.dart';
import 'package:instacar/core/services/user_service.dart';

class CaronasPage extends StatefulWidget {
  const CaronasPage({super.key});

  @override
  State<CaronasPage> createState() => _CaronasPageState();
}

class _CaronasPageState extends State<CaronasPage> {
  int currentIndex = 2;
  String searchQuery = '';
  List<dynamic> caronas = [];
  bool isLoading = true;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    fetchCaronas();
  }

  Future<void> _loadCurrentUser() async {
    final userId = await UserService.getCurrentUserId();
    setState(() {
      currentUserId = userId;
    });
  }

  Future<void> fetchCaronas() async {
    final url = Uri.parse('http://localhost:3000/api/caronas');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          caronas = json.decode(response.body);
          print(caronas);
          isLoading = false;
        });
      } else {
        print('Erro ao carregar caronas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCaronas =
        caronas.where((carona) {
          return carona["from"].toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              carona["to"].toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            title: "Minhas Caronas",
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          Expanded(
            child:
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: filteredCaronas.length,
                      itemBuilder: (context, index) {
                        final carona = filteredCaronas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: ListTile(
                            title: Text('${carona["from"]} → ${carona["to"]}'),
                            subtitle: Text('Data: ${carona["date"]}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  onPressed: currentUserId != null ? () {
                                    // Navigate to chat with the carona creator
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          receiveName: carona["driverName"] ?? carona["name"] ?? "Usuário",
                                          userId: currentUserId!,
                                          receiverId: carona["driverId"] ?? carona["motoristaId"] ?? carona["userId"],
                                        ),
                                      ),
                                    );
                                  } : null,
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    final updated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => EditCaronaPage(carona: carona),
                                      ),
                                    );
                                    if (updated == true) {
                                      fetchCaronas(); // Recarrega caronas após edição
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showBarModalBottomSheet(
            context: context,
            builder: (context) => CreateRidePage(),
          );
          // Se a carona foi criada com sucesso, recarrega a lista
          if (result == true) {
            fetchCaronas();
          }
        },
        backgroundColor: Colors.blue, // Blue background
        foregroundColor: Colors.white,
        splashColor: Colors.blue, // White icon color
        child: Icon(Icons.add),
      ),
    );
  }
}
