import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/constants/constants.dart';
import '../components/widgets/custom_button_widget.dart';
import '../components/widgets/custom_textForm_widget.dart';
import '../viewmodel/user_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var _username = '';
  var _name = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _userviewmodel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logOut(context),
            iconSize: 40,
          )
        ],
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera_enhance),
                              onTap: () {
                                _userviewmodel.photoFrom(ImageSource.camera).whenComplete(() => Navigator.of(context).pop());
                              },
                              title: Text('Catch a photo from camera'),
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_album),
                              onTap: () {
                                _userviewmodel.photoFrom(ImageSource.gallery).whenComplete(() => Navigator.of(context).pop());
                              },
                              title: Text('Upload image from gallery'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  backgroundImage:
                      _userviewmodel.image == null ? NetworkImage(_userviewmodel.getUser!.photo ?? ' ') : FileImage(_userviewmodel.image!) as ImageProvider,
                  radius: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Textformfield(
                  onChanged: (val) {
                    _username = val!;
                  },
                  initialText: _userviewmodel.getUser!.username!,
                  label: 'Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please fill the blank';
                    }
                    if (value.length > 12) {
                      return 'Username must < 12 characters';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Textformfield(
                  onChanged: (val) {
                    _name = val!;
                  },
                  label: 'Your name',
                  initialText: _userviewmodel.getUser!.name ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please fill the blank';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Custom_Textformfield(
                  onChanged: (val) {
                    //_phone = val!;
                  },
                  label: 'Phone',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please fill the blank';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 characters';
                    }
                    return null;
                  },
                  type: TextInputType.phone,
                ),
              ),
              Custom_Button(
                onPressed: () => onSubmitButton(context),
                title: 'Save Changes',
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> logOut(BuildContext context) async {
    final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
    var _resp = await _userviewmodel.signOut();
    return _resp;
  }

  Future<void> onSubmitButton(BuildContext context) async {
    final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
    var _newuser = _userviewmodel.getUser;
    if (_formKey.currentState!.validate()) {
      _newuser!.username = _username;
      _newuser.name = _name;
      await _userviewmodel.uploadFile();

      var _return = await _userviewmodel.updateUser(_userviewmodel.getUser!.uid!, _newuser);
      if (!_return) {
        ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text: 'Username is already in use', second: 2));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text: 'Your informations succesfully changed', second: 2, bgColor: Colors.green));
      }
    }
  }
}
