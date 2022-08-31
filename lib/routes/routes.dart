import 'package:badge_ai/pages/home.dart';
import 'package:badge_ai/pages/login.dart';
import 'package:badge_ai/pages/register.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String login = '/';
  static const String register = '/register';
  static const String homePage = '/homePage';
  static const String qrScan = '/homePage/QRscan';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case register:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        );

      case homePage:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(fullname: fullname, doors: doors),
        );

      default:
        throw const FormatException(
            'Route not found, check routes.dart again!');
    }
  }
}
