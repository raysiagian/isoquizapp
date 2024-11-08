import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/forgetPasswordScreen/pages/forgetPasswordWidget.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/loginScreen/pages/loginPage.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/registerScreen/pages/registerPage.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/pages/homePage.dart';
import 'package:quiz_iso_app/views/mainScreen/materiScreen/pages/materiPage.dart';
import 'package:quiz_iso_app/views/mainScreen/profileScreen/pages/profilePage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizCategoryPage.dart';
import 'package:quiz_iso_app/views/mainScreen/wrapper/pages/wrapper.dart';


class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConstants.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRouteConstants.registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case AppRouteConstants.forgetPasswordPage:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
      case AppRouteConstants.wrapper:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case AppRouteConstants.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRouteConstants.profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      // case AppRouteConstants.materiCategoryPage:
      //   return MaterialPageRoute(builder: (_) => MateriCategoryPage());
        case AppRouteConstants.quizCategoryPage:
        return MaterialPageRoute(builder: (_) => QuizCategoryPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Error: Route not found')),
          ),
        );
    }
  }
}