import 'package:flutter/material.dart';

import '../helpers/route_transition.dart';

ThemeData get theme => ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomPageTransitionsBuilder(),
          TargetPlatform.iOS: CustomPageTransitionsBuilder(),
        },
      ),
      fontFamily: 'OpenSans',
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF674188),
        onPrimary: Colors.white,
        secondary: Color(0xFFC3ACD0),
        onSecondary: Colors.white,
        tertiary: Color(0xFFF7EFE5),
        onTertiary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Color(0xFFFFFBF5),
        onBackground: Colors.white,
        surface: Color(0xFF674188),
        onSurface: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
