import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friend_chat/utils/route_generator.dart';
import 'package:friend_chat/style/theme.dart' as Theme;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _SplashScreenState extends State<SplashScreen> {
  String _userId;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      //check if the user still logged in or not
      BackButtonInterceptor.add(myInterceptor);
      Navigator.of(context).pushNamed(loginRoute);
      //    if logged in, go to home screen, if not, go to login screen
    });
  }

  void dispose() {
//    BackButtonInterceptor.remove(myInterceptor);
//    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON PRESSED!"); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        child: Center(
          child: Text('SPLASH SCREEN'),
        ),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors.appBarBlue, Theme.Colors.backgroundBlue],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
//        color: Theme.Colors.backgroundBlue,
      ),
    ));
  }
}
