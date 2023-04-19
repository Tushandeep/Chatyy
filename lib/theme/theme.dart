import 'package:flutter/material.dart';

import '../../helpers/route_transition.dart';

ThemeData get theme => ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomPageTransitionsBuilder(),
          TargetPlatform.iOS: CustomPageTransitionsBuilder(),
        },
      ),
      fontFamily: 'OpenSans',
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.pink,
        accentColor: Colors.white,
        backgroundColor: Colors.pink[200],
        cardColor: Colors.pink.withOpacity(0.7),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
