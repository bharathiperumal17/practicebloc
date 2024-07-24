import 'package:flutter/material.dart';
import 'package:practicebloc/errorpage.dart';
import 'package:practicebloc/home/ui/homepage.dart';
import 'package:practicebloc/write/ui/write_ui.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      case 'WritePage':
        return MaterialPageRoute(
          builder: (context) => const WriteScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
