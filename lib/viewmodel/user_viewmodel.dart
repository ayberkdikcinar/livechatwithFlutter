import 'package:flutter/widgets.dart';
import '../model/user_model.dart';
import '../bases/auth_base.dart';
import '../services/repository.dart';
import '../components/locator/locator.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState? _state;
  final UserRepository? _repository = locator<UserRepository>();
  UserModel? _user;

  UserViewModel() {
    _state = ViewState.Idle;
    currentUser();
  }

  UserModel? get getUser => _user;

  ViewState? get getState => _state;
  void setState(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      setState(ViewState.Busy);
      _user = await _repository!.currentUser();
      return _user;
    } catch (e) {
      print('An error in userviewmodel currentuser' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel?> signIn() async {
    try {
      setState(ViewState.Busy);
      _user = await _repository!.signIn();
      return _user;
    } catch (e) {
      print('An error in userviewmodel signIn' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      setState(ViewState.Busy);
      return _user = await _repository!.signInWithGoogle();
    } catch (e) {
      print('An error in userviewmodel signInWithGoogle' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<bool?> signOut() async {
    bool? _response = false;
    try {
      setState(ViewState.Busy);
      _response = await (_repository!.signOut());
      _user = null;
      return _response;
    } catch (e) {
      print('An error in userviewmodel signout' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel?> createUserWithEmail(String? email, String? password) async {
    try {
      setState(ViewState.Busy);
      _user = await _repository!.createUserWithEmail(email, password);
      return _user;
    } catch (e) {
      print('An error in userviewmodel createUserWithEmail' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String? email, String? password) async {
    try {
      setState(ViewState.Busy);
      _user = await _repository!.signInWithEmail(email, password);
      return _user;
    } catch (e) {
      print('An error in userviewmodel signInWithEmail' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }
}
