import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/views/mainScreen/splashScreen/widget/splashScreenWidget.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const duration = Duration(seconds: 2);
    Timer(duration, navigateToLogin);
  }

  void navigateToLogin() {
    Navigator.pushNamed(
      context,
      AppRouteConstants.loginPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SplashScreenWidget(),
        ),
    );
  }
}
