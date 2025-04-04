import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/filter_option_choice.dart';
import 'package:instacar/presentation/widgets/filter_range.dart';

class HomeModalAdd extends StatefulWidget {
  const HomeModalAdd({super.key});

  @override
  State<HomeModalAdd> createState() => _HomeModalAddState();
}

class _HomeModalAddState extends State<HomeModalAdd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Tipo de veículo",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold  ),
              ),
              SingleSegmentedButton(),
              Padding(padding: EdgeInsets.only(bottom: 25)),
              Divider(),
              Text(
                "Faixa etária",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold  ),
              ),
              CustomThumbShapeRangeSlider(),
            ],
          )),
        ),
    );
  }
}
