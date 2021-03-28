import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../bases/auth_base.dart';
import '../components/locator/locator.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';
import '../services/user_repository.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState? _state;
  final UserRepository _repository = locator<UserRepository>();
  UserModel? _user;

  UserViewModel() {
    _state = ViewState.Idle;
    currentUser();
  }
  File? image;

  void setImage(File image1) {
    image = image1;
    notifyListeners();
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
      _user = await _repository.currentUser();
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
      _user = await _repository.signIn();
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
      return _user = await _repository.signInWithGoogle();
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
      _response = await (_repository.signOut());
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
      _user = await _repository.createUserWithEmail(email, password);
      return _user;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String? email, String? password) async {
    try {
      setState(ViewState.Busy);
      _user = await _repository.signInWithEmail(email, password);
      return _user;
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<bool> updateUser(String userid, UserModel user) async {
    var a = await _repository.updateUser(userid, user);

    return a;
  }

  Future<String> uploadFile() async {
    var link;
    if (image != null) {
      link = await _repository.uploadFile(_user!.uid!, image!);
      _user!.photo = link;
    } else {
      link = _user!.photo!;
    }
    notifyListeners();
    return link;
  }

  Future<List<UserModel>> fetchAllUsers() async {
    return await _repository.fetchAllUsers();
  }

  Stream<List<Message>> getAllMessagesBetween(String? receiverUserId, String? currentUserId) {
    return _repository.getAllMessagesBetween(receiverUserId, currentUserId);
  }

  Future<bool> saveMessage(Message message) {
    notifyListeners();
    return _repository.saveMessage(message);
  }

  Future<List<UserModel>> getChattedUsers(String userid) {
    //notifyListeners();
    return _repository.getChattedUsers(userid);
  }

  Future<void> photoFrom(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setImage(File(pickedFile.path));
    }
  }

  Future<Message> getLastMessageBetween(String? to, String? from) {
    return _repository.getLastMessageBetween(to, from);
  }
}
