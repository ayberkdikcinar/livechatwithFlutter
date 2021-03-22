import 'package:flutter/cupertino.dart';

import '../tab_item.dart';

class HomeViewModel with ChangeNotifier {
  TabItem _currentTab = TabItem.Home;

  void setCurrentTab(TabItem tabItem) {
    _currentTab = tabItem;
    notifyListeners();
  }

  TabItem get getCurrentTab => _currentTab;
}
