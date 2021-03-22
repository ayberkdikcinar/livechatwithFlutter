import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Home, Profile }

class TabItemData {
  final String? label;
  final IconData? icon;

  TabItemData(this.label, this.icon);

  static Map<TabItem, TabItemData> allPages = {
    TabItem.Home: TabItemData('Home', Icons.home),
    TabItem.Profile: TabItemData('Profile', Icons.person),
  };
}
