import 'package:flutter/material.dart';
import 'package:instacar/presentation/widgets/home_modal_add.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

FloatingActionButton getHomeFab( BuildContext context){
  return FloatingActionButton(
    child: Icon(
      IconData(0xf068, fontFamily: 'MaterialIcons'),
    ),
    onPressed: () {
      showBarModalBottomSheet(
        context: context,
        builder: (context) => HomeModalAdd()
      );
    },
  );
}