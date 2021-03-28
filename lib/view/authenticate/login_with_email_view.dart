import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../components/constants/constants.dart';
import '../../components/widgets/custom_button_widget.dart';
import '../../components/widgets/custom_textForm_widget.dart';
import '../../firebase_error.dart';
import '../../viewmodel/login_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';

//enum Current_State { Register, Login }

class LoginWithEmailView extends StatefulWidget {
  LoginWithEmailView({Key? key}) : super(key: key);

  @override
  _LoginWithEmailViewState createState() => _LoginWithEmailViewState();
}

class _LoginWithEmailViewState extends State<LoginWithEmailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String? _email;
  late String? _password;

  @override
  Widget build(BuildContext context) {
    var _buttonText = '';
    var _reminderText = '';
    final _userviewmodel = Provider.of<UserViewModel>(context);
    if (Provider.of<LoginViewModel>(context).getCurrentState == Current_State.Login) {
      _reminderText = 'Do you not hava an account? Register now..';
      _buttonText = 'Login';
    } else {
      _reminderText = 'Do you hava an account? Login now..';
      _buttonText = 'Register';
    }
    if (_userviewmodel.getUser != null) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.of(context).pop();
      });
    }
    return Scaffold(
      appBar: AppBar(),
      body: _userviewmodel.getState == ViewState.Idle
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Custom_Textformfield(
                            validator: (value) {},
                            hint: 'E-mail',
                            onChanged: (val) {
                              _email = val;
                            },
                            icon: Icons.email),
                        emptySpace,
                        Custom_Textformfield(
                            validator: (value) {},
                            hint: 'Password',
                            onChanged: (val) {
                              _password = val;
                            },
                            icon: Icons.lock),
                        loginButton(_buttonText),
                        reminderText(_reminderText),
                      ],
                    )),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Container loginButton(String text) {
    return Container(
      width: dynamicWidth(context, 0.3),
      child: Custom_Button(
        onPressed: () async {
          _formKey.currentState!.save();
          if (text == 'Login') {
            await signInWithEmail(_email, _password);
          } else {
            await createUserWithEmail(_email, _password);
          }
        },
        title: text,
        color: color2,
      ),
    );
  }

  InkWell reminderText(String text) {
    return InkWell(
      onTap: () {
        if (Provider.of<LoginViewModel>(context, listen: false).getCurrentState == Current_State.Login) {
          Provider.of<LoginViewModel>(context, listen: false).setCurrentState(Current_State.Register);
        } else {
          Provider.of<LoginViewModel>(context, listen: false).setCurrentState(Current_State.Login);
        }
      },
      child: Text(text),
    );
  }

  SizedBox get emptySpace => SizedBox(height: 10);

  Future<void> signInWithEmail(String? email, String? password) async {
    try {
      final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
      await _userviewmodel.signInWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      final _snackbar = buildSnackBar(text: FB_Error.getError(e.code)!);
      ScaffoldMessenger.of(context).showSnackBar(_snackbar);
    }
  }

  Future<void> createUserWithEmail(String? email, String? password) async {
    try {
      final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
      await _userviewmodel.createUserWithEmail(email, password);
    } on PlatformException catch (e) {
      final _snackbar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(_snackbar);
    } on FirebaseAuthException catch (e) {
      final _snackbar = buildSnackBar(text: FB_Error.getError(e.code)!);
      ScaffoldMessenger.of(context).showSnackBar(_snackbar);
    }
  }
}
