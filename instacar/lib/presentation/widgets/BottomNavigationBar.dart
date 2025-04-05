import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  static const List<TabItem> items = [
    TabItem(icon: Icons.home),
    TabItem(icon: Icons.favorite_border, title: 'Favoritos'),
    TabItem(icon: Icons.car_crash_outlined, title: 'Caronas'),
    TabItem(icon: Icons.chat, title: 'Chat'),
    TabItem(icon: Icons.account_box, title: 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomBarInspiredInside(
      items: items,
      backgroundColor: const Color(0xFF1752FE),
      color: const Color(0xFF96B1FD),
      colorSelected: Colors.white,
      indexSelected: selectedIndex,
      onTap: onItemSelected,
      chipStyle: const ChipStyle(
        convexBridge: true,
      ),
      itemStyle: ItemStyle.circle,
      animated: false,
    );
  }
}
