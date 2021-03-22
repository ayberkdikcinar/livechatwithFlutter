import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/user_viewmodel.dart';
import 'authenticate/welcome_view.dart';
import 'home_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userviewmodel = Provider.of<UserViewModel>(context);
    if (_userviewmodel.getState == ViewState.Idle) {
      if (_userviewmodel.getUser != null) {
        return HomeView();
      } else {
        return WelcomeView();
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
