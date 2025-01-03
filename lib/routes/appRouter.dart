import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/forgetPasswordScreen/pages/forgetPasswordWidget.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/loginScreen/pages/loginPage.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/registerScreen/pages/chooseGenderPage.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/registerScreen/pages/registerPage.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/pages/homePage.dart';
import 'package:quiz_iso_app/views/mainScreen/profileScreen/pages/profilePage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryWrapperPage.dart';
import 'package:quiz_iso_app/views/mainScreen/splashScreen/pages/splashScreenPage.dart';
import 'package:quiz_iso_app/views/mainScreen/wrapper/pages/wrapper.dart';


class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConstants.splashsscrreenPage:
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
      case AppRouteConstants.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRouteConstants.registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      // case AppRouteConstants.genderPage:
      //   return MaterialPageRoute(builder: (_) => ChooseGenderPage(

      //   ));
      case AppRouteConstants.genderPage:
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => ChooseGenderPage(
              username: args['userName'] ?? '',
              email: args['email'] ?? '',
              phoneNumber: args['phoneNumber'] ?? '',
              password: args['password'] ?? '',
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('Error: Invalid arguments for ChooseGenderPage'),
              ),
            ),
          );
        }

      case AppRouteConstants.forgetPasswordPage:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
      case AppRouteConstants.wrapper:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case AppRouteConstants.homePage:
        return MaterialPageRoute(builder: (_) => HomePage(
          token:'token',
        ));
      case AppRouteConstants.profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      // case AppRouteConstants.quizPage:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => QuizSubCategoryWrapperPage(
      //       quizCategory: args['quizCategory'],
      //       id_quizCategory: args['id_quizCategory'],
      //       isoquizcategorymodel: args['isoquizcategorymodel'],
      //     ),
      //   );
      case AppRouteConstants.quizSubCategoryWrapperPage:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => QuizSubCategoryWrapperPage(
            isoquizcategorymodel: args['quizCategory'],
            // id_quizCategory: args['id_quizCategory'],
            // isoquizcategorymodel: args['isoquizcategorymodel'],
          ),
        );
      // case AppRouteConstants.materiCategoryPage:
      //   return MaterialPageRoute(builder: (_) => MateriCategoryPage());
      // case AppRouteConstants.quizSubCategoryPage:
      //   return MaterialPageRoute(builder: (_) => QuizSubCategoryPage());
      // case AppRouteConstants.materialPage:
      //   return MaterialPageRoute(builder: (_) => QuizMaterialPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Error: Route not found')),
          ),
        );
    }
  }
}