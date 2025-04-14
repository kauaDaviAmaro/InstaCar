import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/RideListWidget.dart';
import 'package:instacar/presentation/widgets/navbar.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            title: "Favoritos",
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          Expanded(
            child: RideListWidget(
              searchQuery: searchQuery,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
    );
  }
}
