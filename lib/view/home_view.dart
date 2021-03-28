import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_bottom_navigation.dart';
import '../tab_item.dart';
import '../viewmodel/home_viewmodel.dart';
import 'main_communication_view.dart';
import 'profile_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: prefer_final_fields

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.Home: CommunicationView(),
      TabItem.Profile: ProfileView(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomBottomNavigation(
        onSelected: (onSelectedTab) {
          context.read<HomeViewModel>().setCurrentTab(onSelectedTab);
        },
        currentTab: context.watch<HomeViewModel>().getCurrentTab,
        createPage: allPages(),
      ),
    );
  }
}
