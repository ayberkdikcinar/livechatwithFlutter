import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import 'all_users_view.dart';
import 'chat_view.dart';

class CommunicationView extends StatefulWidget {
  const CommunicationView({Key? key}) : super(key: key);

  @override
  _CommunicationViewState createState() => _CommunicationViewState();
}

class _CommunicationViewState extends State<CommunicationView> {
  @override
  Widget build(BuildContext context) {
    final _userviewmodel = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Last Connections'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AllUsersView(),
            ));
          },
          child: Icon(Icons.chat),
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshPage(),
          child: FutureBuilder<List<UserModel>>(
            future: _userviewmodel
                .getChattedUsers(_userviewmodel.getUser!.uid!), //_userviewmodel.fetchAllUsers(), //_fb.getChattedUsers(_userviewmodel.getUser!.uid!), // //
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
                          child: FutureBuilder<Message>(
                              future: _userviewmodel.getLastMessageBetween(_allUsers[index].uid!, _userviewmodel.getUser!.uid!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListTile(
                                    title: Text(_allUsers[index].username!),
                                    subtitle: Text(snapshot.data!.body!),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(_allUsers[index].photo!),
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text('Last message'),
                                        Text(timeDifference(snapshot.data!.date!.toDate())),
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              }),
                        ),
                      );
                    } else {
                      return Text('');
                    }
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() async {
    setState(() {});
  }

  String timeDifference(DateTime d1) {
    var diff = DateTime.now().difference(d1);
    if (diff.inDays > 0) {
      return diff.inDays.toString() + ' days ago';
    }
    if (diff.inHours > 0) {
      return diff.inHours.toString() + ' hours ago';
    }
    if (diff.inMinutes > 0) {
      return diff.inMinutes.toString() + ' minutes ago';
    }
    if (diff.inSeconds > 0) {
      return diff.inSeconds.toString() + ' seconds ago';
    }
    return '';
  }
}
