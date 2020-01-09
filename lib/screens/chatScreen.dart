import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_chat/utils/route_generator.dart';
import 'package:friend_chat/style/theme.dart' as Theme;
import 'package:friend_chat/common/app_bar.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.friendName});

  final friendName;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Chat> _chatList = [];
  bool _isloadingInitialData;
  @override
  void initState() {
    super.initState();

    _getChatList();
  }

  Future<void> _getChatList() async {
    setState(() {
      _isloadingInitialData = true;
    });
    http.get('http://5d1d957c3374890014f0041b.mockapi.io/places').then((res) {
      var jsonData = json.decode(res.body);

      List<Chat> chatList = [];
      for (var u in jsonData) {
        Chat chat = Chat(u["name"], u["message"]);
        chatList.add(chat);
      }
      setState(() {
        _chatList = chatList;
        _isloadingInitialData = false;
      });
    }).catchError((err) {
      setState(() {
        _isloadingInitialData = false;
      });
      print(err);
    });
  }

  Widget ListDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey[300]),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    // TODO: Chat is not working yet, follow https://www.youtube.com/watch?v=WwhyaqNtNQY or https://www.youtube.com/redirect?v=WwhyaqNtNQY&redir_token=WdQS_aiy4k8iS5b9g-YCuFlFA9B8MTU3ODY4MTIxMkAxNTc4NTk0ODEy&event=video_description&q=https%3A%2F%2Fgithub.com%2Ftensor-programming%2Fdart_flutter_chat_app
    // TODO: also can try using https://pub.dev/packages/dash_chat for chat UI
    return Scaffold(
        appBar: CustomAppBar(widget.friendName),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: _isloadingInitialData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    child: ListView.builder(
                      itemCount: _chatList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: InkWell(
//                                splashColor: ,
                                    onTap: () {},
                                    child: Container(
//                                        decoration: BoxDecoration(
//                                          borderRadius: BorderRadius.all(
//                                              Radius.circular(10)),
//                                        ),
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            _chatList[i].name == "Surya Permana"
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_chatList[i].name),
                                          Text(_chatList[i].message),
                                        ],
                                      ),
                                    )))),
                          ),
                        );
                      },
                    ),
                    onRefresh: _getChatList)));
  }
}

class Chat {
  final String name;
  final String message;

  Chat(this.name, this.message);
}
