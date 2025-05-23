import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/filter_option_choice_gender.dart';
import 'package:instacar/presentation/widgets/filter_option_choice_space_car.dart';
import 'package:instacar/presentation/widgets/filter_option_choice_vehicle.dart';
import 'package:instacar/presentation/widgets/filter_order.dart';
// import 'package:instacar/presentation/widgets/filter_option_choice_vehicles.dart';
import 'package:instacar/presentation/widgets/filter_range_age.dart';
import 'package:instacar/presentation/widgets/tittle_generator.dart';

class HomeModalAdd extends StatefulWidget {
  const HomeModalAdd({super.key});

  @override
  State<HomeModalAdd> createState() => _HomeModalAddState();
}

class _HomeModalAddState extends State<HomeModalAdd> {
  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Opções para selecao de Veiculos
                TittleGenerator(context, 'Tipo de veículo:'),
                ChoiceChipWidgetVehicle(),
                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 25)),
                //Range de idade
                TittleGenerator(context, 'Faixa etária:'),
                CustomThumbShapeRangeSlider(),
                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 25)),
                TittleGenerator(context, 'Gênero:'),
                //Opções para selecao de Gênero
                ChoiceChipWidget(),
                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 25)),
                //Opções para selecao de Vagas no carro
                TittleGenerator(context, 'Vagas no carro:'),
                ChoiceChipWidgetSpace(),
                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 25)),
                //Opções para ordenar o filtro
                TittleGenerator(context, 'Ordenar Filtro por:'),
                ChoiceChipFilterOrder(),

                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 25)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(100, 141, 219, 1),
                  ),
                  child: Text(
                    'Filtrar',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
