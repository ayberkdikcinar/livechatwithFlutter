import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livechat/tab_item.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key, required this.currentTab, required this.onSelected, required this.createPage}) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelected;
  final Map<TabItem, Widget> createPage;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _navigationItem(TabItem.Home),
          _navigationItem(TabItem.Profile),
        ],
        onTap: (index) => onSelected(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return createPage[TabItem.values[index]]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem _navigationItem(TabItem _tabitem) {
    final _createTab = TabItemData.allPages[_tabitem];
    return BottomNavigationBarItem(icon: Icon(_createTab!.icon), label: _createTab.label);
  }
}
