import 'package:flutter/material.dart';

import '../../../view/pages/home_page/components/map_component/map_component.dart';
import '../../../view/pages/home_page/components/profile_component/profile_component.dart';
import '../../../view/pages/home_page/components/shop_component/shop_component.dart';

class BottomBarItems {
  static BottomBarItems? _instance;
  BottomBarItems._();
  static BottomBarItems get instance => _instance ??= BottomBarItems._();

  final List<Widget> pages = const <Widget>[
    MapComponent(),
    ShopComponent(),
    ProfileComponent()
  ];

  final List<BottomNavigationBarItem> items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_basket),
      label: 'Shop',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    )
  ];
}
