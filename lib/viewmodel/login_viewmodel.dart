import 'package:flutter/cupertino.dart';

enum Current_State { Register, Login }

class LoginViewModel with ChangeNotifier {
  Current_State _currentstate = Current_State.Login;

  void setCurrentState(Current_State currentState) {
    _currentstate = currentState;
    notifyListeners();
  }

  Current_State get getCurrentState => _currentstate;
}
