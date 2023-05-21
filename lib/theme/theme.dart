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
      scaffoldBackgroundColor: const Color.fromRGBO(255, 251, 245, 1),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(103, 65, 136, 1),
        secondary: Color.fromRGBO(195, 172, 208, 1),
        tertiary: Color.fromRGBO(247, 239, 229, 1),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Color.fromRGBO(255, 251, 245, 1),
        onBackground: Colors.white,
        surface: Color.fromRGBO(103, 65, 136, 1),
        onSurface: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Color.fromRGBO(103, 65, 136, 1),
      ),
    );
