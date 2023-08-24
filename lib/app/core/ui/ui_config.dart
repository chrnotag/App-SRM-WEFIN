import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'Wefin';

  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xff05204f),
        primaryColorDark: const Color(0xff336797),
        primaryColorLight: const Color(0xffDDE9C7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffd19214),
        ),
      );
}
