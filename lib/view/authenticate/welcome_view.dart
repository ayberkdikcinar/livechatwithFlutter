import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/constants/constants.dart';
import '../../components/widgets/custom_button_widget.dart';
import '../../viewmodel/user_viewmodel.dart';
import 'login_with_email_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: dynamicHeight(context, 1),
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset('assets/images/main_top.png'),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_bottom.png',
                  width: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
              buildCenterBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Center buildCenterBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Just Welcome',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          emptySpace,
          SvgPicture.asset(
            'assets/icons/chat.svg',
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          buildLoginButton(context),
          buildLoginWithGoogleButton(context),
          buildRegisterButton(context)
        ],
      ),
    );
  }

  Widget get emptySpace => SizedBox(height: 10);

  Widget buildLoginWithGoogleButton(BuildContext context) {
    return Container(
      width: dynamicWidth(context, 0.6),
      child: Custom_Button(
        onPressed: () => signInGoogle(context),
        title: 'Login With Google',
        color: color1,
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      width: dynamicWidth(context, 0.6),
      child: Custom_Button(
        onPressed: () => signInRandomly(context),
        title: 'Login',
        color: color2,
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    return Container(
      width: dynamicWidth(context, 0.6),
      child: Custom_Button(
        onPressed: () => routingSignInEmail(context),
        title: 'Login With Email',
        color: color2,
      ),
    );
  }

  void signInRandomly(BuildContext context) {
    final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
    _userviewmodel.signIn();
  }

  void signInGoogle(BuildContext context) {
    final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
    try {
      _userviewmodel.signInWithGoogle();
    } catch (e) {
      print('welcomeviewde googlela girşi hatası' + e.toString());
    }
  }

  void routingSignInEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginWithEmailView(),
    ));
  }
}
