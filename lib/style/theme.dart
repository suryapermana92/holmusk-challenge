import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = const Color(0xFFFFFFFF);
  static const Color loginGradientEnd = const Color(0xFFd4d4d4);
  static const Color loginButtonColor = const Color(0xFF15ff99);
  static const Color zurichBlue = const Color(0xFF000066);
  static const Color zurichOrange = const Color(0xFFF69C00);
  static const Color appBarBlue = const Color(0xFF0557AA);
  static const Color backgroundBlue = const Color(0xFFD6DFEE);
  static const Color emergencyRed = const Color(0xFFEA635C);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
