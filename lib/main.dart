import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livechat/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

import 'components/locator/locator.dart';
import 'view/landing_view.dart';
import 'viewmodel/login_viewmodel.dart';
import 'viewmodel/user_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LandingView(),
      theme: ThemeData.dark(),
    );
  }
}
