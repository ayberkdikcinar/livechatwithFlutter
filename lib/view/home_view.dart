import 'package:flutter/material.dart';
import 'package:livechat/custom_bottom_navigation.dart';
import 'package:livechat/tab_item.dart';
import 'package:livechat/view/communication_view.dart';
import 'package:livechat/view/profile_view.dart';
import 'package:livechat/viewmodel/home_viewmodel.dart';
import '../viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

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
          print('Onselected Tab:' + onSelectedTab.toString());
          context.read<HomeViewModel>().setCurrentTab(onSelectedTab);
        },
        currentTab: context.watch<HomeViewModel>().getCurrentTab,
        createPage: allPages(),
      ),
    );
  }

  Future<bool?> logOut(BuildContext context) async {
    final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
    var _resp = await _userviewmodel.signOut();
    return _resp;
  }
}
