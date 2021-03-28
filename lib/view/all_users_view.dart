import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import 'chat_view.dart';

class AllUsersView extends StatelessWidget {
  const AllUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userviewmodel = Provider.of<UserViewModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Users'),
        ),
        body: FutureBuilder<List<UserModel>>(
          future: _userviewmodel.fetchAllUsers(), //_fb.getChattedUsers(_userviewmodel.getUser!.uid!), //
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _allUsers = snapshot.data;
              return ListView.builder(
                itemCount: _allUsers!.length,
                itemBuilder: (context, index) {
                  if (_allUsers[index].uid != Provider.of<UserViewModel>(context).getUser!.uid) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                          builder: (context) => ChatView(choosenUser: _allUsers[index]),
                        ));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(_allUsers[index].username!),
                          subtitle: Text(_allUsers[index].email!),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(_allUsers[index].photo!),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text('');
                  }

                  //Text(_allUsers[index].email!);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
