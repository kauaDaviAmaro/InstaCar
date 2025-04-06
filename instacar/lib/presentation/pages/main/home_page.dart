import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/BottomNavigationBar.dart';
import 'package:instacar/presentation/widgets/RideListWidget.dart';
import 'package:instacar/presentation/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            title: "Página Principal",
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          Expanded(child: RideListWidget(searchQuery: searchQuery)),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: currentIndex),
    );
  }
}
