import 'package:flutter/material.dart';
import 'package:friend_chat/style/theme.dart' as Theme;

PreferredSizeWidget CustomAppBar(title) {
  return new AppBar(
    brightness: Brightness.dark,
    title: Text(title),
    iconTheme: IconThemeData(
      color: Colors.white, //change  your color here
    ),
    backgroundColor: Color(0xFF0557AA),
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(
          fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}
