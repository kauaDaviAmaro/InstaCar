import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/home_fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caronas Disponíveis"),
      ),
      floatingActionButton: getHomeFab(context),
    );
  }
}
 