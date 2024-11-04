import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/pages/homePage.dart';
import 'package:quiz_iso_app/views/mainScreen/materiScreen/pages/materiPage.dart';
import 'package:quiz_iso_app/views/mainScreen/profileScreen/pages/profilePage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizPage.dart';
import 'package:quiz_iso_app/views/mainScreen/wrapper/pages/wrapper.dart';


class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConstants.wrapper:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case AppRouteConstants.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRouteConstants.profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case AppRouteConstants.materiPage:
        return MaterialPageRoute(builder: (_) => MateriPage());
        case AppRouteConstants.quizPage:
        return MaterialPageRoute(builder: (_) => QuizPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Error: Route not found')),
          ),
        );
    }
  }
}