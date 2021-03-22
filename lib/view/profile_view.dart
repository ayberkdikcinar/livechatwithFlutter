import 'package:flutter/material.dart';
import 'package:livechat/view/test_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.ac_unit_outlined),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TestView(),
                ));
              })
        ],
      ),
      body: Center(
        child: Text('Profile View'),
      ),
    );
  }
}
