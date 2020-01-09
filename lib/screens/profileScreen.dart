import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_chat/utils/route_generator.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool _isloadingInitialData;
  Map<String, dynamic> _myProfile = {};
  @override
  void initState() {
    super.initState();
//    getMyProfileFromString();
    getMyProfileFromApi();
  }

  Future<void> getMyProfileFromApi() async {
    setState(() {
      _isloadingInitialData = true;
    });
    http.get('http://5d1d957c3374890014f0041b.mockapi.io/parking').then((res) {
      var jsonData = json.decode(res.body);

      setState(() {
        _myProfile = jsonData;
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
            : Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.network(_myProfile["avatarUrl"])),
                  ),
                  Text(
                    _myProfile["name"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(_myProfile["age"].toString() + " years"),
                  RaisedButton(
                    child: Text('Refresh Profile'),
                    onPressed: () {
                      getMyProfileFromApi();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide()),
                  ),
                  RaisedButton(
                    child: Text('Edit Profile'),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide()),
                  ),
                ],
              ));
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
