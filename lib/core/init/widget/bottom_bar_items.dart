import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../view/home/home_page/view/map_component.dart';
import '../../../view/home/profile_page/view/profile_component.dart';
import '../../../view/home/shop_page/view/shop_page.dart';

class BottomBarItems {
  static BottomBarItems? _instance;
  BottomBarItems._();
  static BottomBarItems get instance => _instance ??= BottomBarItems._();

  final List<Widget> pages = const <Widget>[
    MapComponent(),
    ShopPage(),
    ProfilePage()
  ];

  final List<GButton> items = const <GButton>[
    GButton(
      icon: Icons.home_filled,
      text: 'Ana Sayfa',
    ),
    GButton(
      icon: Icons.shopping_bag_outlined,
      text: 'Mağaza',
    ),
    GButton(
      icon: Icons.person_outline_outlined,
      text: 'Profil',
    ),
  ];
}
