import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/constants/constants.dart';
import '../components/widgets/custom_button_widget.dart';
import '../components/widgets/custom_textfield_widget.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';
import '../viewmodel/user_viewmodel.dart';

class ChatView extends StatefulWidget {
  final UserModel? choosenUser;
  ChatView({Key? key, this.choosenUser}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();
    final _currentUserId = Provider.of<UserViewModel>(context, listen: false).getUser!.uid;
    final _receiverUserId = widget.choosenUser!.uid;
    final _userviewmodel = Provider.of<UserViewModel>(context, listen: false);
    var _scrollController = ScrollController();
    var _messageText;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.choosenUser!.photo!),
              ),
              emptySpaceWidth,
              Text(widget.choosenUser!.username!),
            ],
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => true);
                //Navigator.of(context).pop();
                //Navigator.of(context).pop();
              }),
          //CircleAvatar(backgroundImage: NetworkImage(widget.choosenUser!.photo!),),
        ),
        body: Column(
          children: [
            StreamBuilder<List<Message>>(
              stream: _userviewmodel.getAllMessagesBetween(_receiverUserId, _currentUserId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return arrangeChatBody(snapshot.data![index]);
                        //return Text(snapshot.data![index].body!);
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Custom_TextField(
                      controller: _textController,
                      onChanged: (val) => {_messageText = val},
                    ),
                  ),
                  emptySpaceWidth,
                  Custom_Button(
                    onPressed: () async {
                      _textController.clear();
                      if (_messageText.toString().trim().isNotEmpty) {
                        await _userviewmodel.saveMessage(Message(body: _messageText, to: _receiverUserId, from: _currentUserId, date: Timestamp.now()));
                        _messageText = ' ';
                        await _scrollController.animateTo(0.0, duration: Duration(milliseconds: 50), curve: Curves.easeInOut);
                      }
                    },
                    title: 'Send',
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget arrangeChatBody(Message msg) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: msg.isOwner == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: msg.isOwner == true ? colorSender : colorReceiver),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
            //height: dynamicHeight(context, 0.07),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    msg.body!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                emptySpaceWidth,
                Text(
                  msg.date!.toDate().hour.toString() + ':' + msg.date!.toDate().minute.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
