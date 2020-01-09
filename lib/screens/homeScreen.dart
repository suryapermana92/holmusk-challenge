import 'dart:convert';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:friend_chat/utils/route_generator.dart';
//import 'package:friend_chat/style/theme.dart' as Theme;
import 'package:friend_chat/common/app_bar.dart';
import 'package:friend_chat/screens/friendListScreen.dart';
import 'package:friend_chat/screens/profileScreen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _children = [FriendList(), MyProfile()];
  static const List<String> _titleList = ['Friend List', 'My Profile'];

//  void getFriendListFromString() {
//    var friendList = [];
//    _friendJsonData.forEach((data) {
//      Friend friend = new Friend.fromJson(jsonDecode(data));
//      friendList.add(friend);
//    });
//  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void showChooser() {
    showDialog<void>(
        context: context,
        builder: (context) {
          return BrightnessSwitcherDialog(
            onSelectedTheme: (brightness) {
              DynamicTheme.of(context).setBrightness(brightness);
            },
          );
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

  _removeSession() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLoggedIn';
    prefs.setBool(key, false);
//    print('saved $key true');
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Friend List'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('My Profile'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        appBar: CustomAppBar(_titleList[_selectedIndex]),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: double.infinity,
                  child: DrawerHeader(
                    child: Image.asset('assets/holmusk-image.png'),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]))),
                  ),
                ),
                ListTile(
                  leading: Container(
                      width: 60, child: Icon(Icons.lightbulb_outline)),
                  title: Text('Change Theme'),
                  onTap: () {
                    changeBrightness();
                  },
                ),
                ListDivider(),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: Container(width: 60, child: Icon(Icons.exit_to_app)),
                  title: Text('Sign Out'),
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(loginRoute));
                    _removeSession();
                    DynamicTheme.of(context).setBrightness(Brightness.light);
                  },
                ),
                ListDivider(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        body: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: _children[_selectedIndex]));
  }
}
