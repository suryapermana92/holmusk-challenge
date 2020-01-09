import 'package:flutter/material.dart';
//import 'package:good_driver_app/screens/EmergencyPage.dart';
import 'package:friend_chat/screens/homeScreen.dart';
//import 'package:gooddriver/screens/navigationScreen.dart';
//import 'package:gooddriver/screens/tutorialScreen.dart';
import 'package:friend_chat/screens/splashScreen.dart';
import 'package:friend_chat/screens/loginScreen.dart';
import 'package:friend_chat/screens/chatScreen.dart';
//import 'package:gooddriver/screens/emergencyFeedbackScreen.dart';
//import 'package:gooddriver/screens/garageScreen.dart';
//import 'package:gooddriver/screens/garageFeedbackScreen.dart';
//import 'package:gooddriver/screens/garageBookScreen.dart';
//import 'package:gooddriver/screens/garageThankYouScreen.dart';
//import 'package:gooddriver/screens/changePasswordScreen.dart';
//import 'package:gooddriver/screens/changePasswordSuccessScreen.dart';
//import 'package:gooddriver/screens/trafficInfoScreen.dart';
//import 'package:gooddriver/screens/voucherDetailScreen.dart';
//import 'package:gooddriver/screens/voucherListScreen.dart';
//import 'package:gooddriver/screens/parkingListScreen.dart';
//import 'package:gooddriver/screens/parkingDetailScreen.dart';
//import 'package:gooddriver/screens/parkingWriteReviewScreen.dart';
//import 'package:gooddriver/screens/parkingThankYouScreen.dart';
//import 'package:gooddriver/screens/appThankYouScreen.dart';
//import 'package:gooddriver/screens/forgotPasswordScreen.dart';

const indexRoute = '/';
//const navigationRoute = 'navigationScreen';
const homeRoute = 'homeScreen';
//const tutorialRoute = 'tutorialScreen';
const loginRoute = 'loginScreen';
const chatRoute = 'chatScreen';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case indexRoute:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(),
            settings: RouteSettings(name: "splashScreen"));

      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(),
            settings: RouteSettings(name: loginRoute));
      case chatRoute:
        return MaterialPageRoute(
            builder: (_) => ChatScreen(friendName: settings.arguments),
            settings: RouteSettings(
              name: chatRoute,
            ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(child: Text('ERROR 404')),
      );
    });
  }
}
