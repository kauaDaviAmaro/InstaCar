import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instacar/presentation/pages/main/edit_ride_page.dart';
import 'dart:convert';

import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';
import 'package:instacar/presentation/widgets/navbar.dart';

class CaronasPage extends StatefulWidget {
  const CaronasPage({Key? key}) : super(key: key);

  @override
  State<CaronasPage> createState() => _CaronasPageState();
}

class _CaronasPageState extends State<CaronasPage> {
  int currentIndex = 3;
  String searchQuery = '';
  List<dynamic> caronas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCaronas();
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
                            trailing: IconButton(
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
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: currentIndex),
    );
  }
}
