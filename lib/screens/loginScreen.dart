import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friend_chat/common/app_bar.dart';
import 'package:friend_chat/utils/route_generator.dart';
import 'package:friend_chat/style/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _LoginScreenState extends State<LoginScreen> {
  String _userId;
  bool isLoggedIn = false;
  Future<bool> _getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('isLoggedIn') ?? false;
    return value;
  }

  @override
  void initState() {
    super.initState();
    _getLoginStatus().then((bool value) {
      value ? Navigator.of(context).pushNamed(homeRoute) : null;
    });

    //check if the user still logged in or not

    BackButtonInterceptor.add(myInterceptor);
    //    if logged in, go to home screen, if not, go to login screen
  }

  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON PRESSED!"); // Do some stuff.
    return true;
  }

  _persistSession() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLoggedIn';
    prefs.setBool(key, true);
//    print('saved $key true');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome to Holmusk",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      // TODO: Create proper login & signup module
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email Address",
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      RaisedButton(
                        child: Text('Log in'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(homeRoute);
                          _persistSession();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide()),
                      ),
                    ],
                  ),
//        color: Theme.Colors.backgroundBlue,
                ),
              ),
            )));
  }
}
