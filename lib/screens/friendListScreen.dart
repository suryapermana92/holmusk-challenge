import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_chat/utils/route_generator.dart';
import 'package:http/http.dart' as http;

class FriendList extends StatefulWidget {
  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  bool _isloadingInitialData;
  List<Friend> _friendList = [];
  @override
  void initState() {
    super.initState();
    _getFriendListFromApi();
  }

  Future<void> _getFriendListFromApi() async {
    setState(() {
      _isloadingInitialData = true;
    });
    http
        .get('http://5d1d957c3374890014f0041b.mockapi.io/adsService')
        .then((res) {
      var jsonData = json.decode(res.body);
      List<Friend> friendList = [];
      for (var u in jsonData) {
        Friend friend =
            Friend(u["id"], u["name"], u["avatarUrl"], u["lastMessage"]);
        friendList.add(friend);
      }
      setState(() {
        _friendList = friendList;
        _isloadingInitialData = false;
      });
    }).catchError((err) {
      setState(() {
        _isloadingInitialData = false;
      });
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
//              decoration: BoxDecoration(color: Colors.white),
        child: _isloadingInitialData
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: ListView.builder(
                  itemCount: _friendList.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            color: Colors.white,
                            child: InkWell(

//                                splashColor: ,
                                onTap: () {
                                  Navigator.of(context).pushNamed(chatRoute,
                                      arguments: _friendList[i].name);
                                },
                                child: Container(
//                                        decoration: BoxDecoration(
//                                          borderRadius: BorderRadius.all(
//                                              Radius.circular(10)),
//                                        ),
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        child: ClipRRect(
                                          child: Image.network(
                                              _friendList[i].avatarUrl),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
//                                          Text(_friendList[i].id),
                                          Text(
                                            _friendList[i].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
//                                          Text(_friendList[i].avatarUrl),
                                          Text(_friendList[i].lastMessage),
                                        ],
                                      ),
                                    ],
                                  ),
                                )))),
                      ),
                    );
                  },
                ),
                onRefresh: _getFriendListFromApi));
  }
}

class Friend {
  String id;
  String name;
  String avatarUrl;
  String lastMessage;

  Friend(this.id, this.name, this.avatarUrl, this.lastMessage);
//  factory Friend.fromJson(Map<String, dynamic> parsedJson) {
//    return Friend()
//      ..id = parsedJson['id'] as String
//      ..name = parsedJson['name'] as String
//      ..avatarUrl = parsedJson['avatarUrl'] as String
//      ..lastMessage = parsedJson['lastMessage'] as String;
//  }
}
