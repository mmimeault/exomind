import 'package:flutter/material.dart';

class MainTheme {
  static get light {
    return ThemeData(
      accentColor: Color(0XFF4267B2),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColor: Colors.white,
    );
  }

  static get dark {
    return ThemeData(
      accentColor: Color(0XFF4267B2),
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      primaryColor: Color(0XFF202020),
    );
  }
}
