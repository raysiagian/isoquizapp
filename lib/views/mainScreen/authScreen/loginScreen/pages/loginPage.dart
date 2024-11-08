import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/loginScreen/widget/loginTextFormWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ISO:27001",
            style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
              color: LocalColorsStyle.primaryColor,
            ),
          ),
          Text(
            "Selamat Datang",
            style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(
            height: 40.0,
          ),
          LoginTextFormWidget(),
        ],
      ),
    );
  }
}