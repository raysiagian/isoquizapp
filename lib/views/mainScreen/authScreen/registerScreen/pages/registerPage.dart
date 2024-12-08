import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/registerScreen/widget/registerTextFormWidget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          RegisterTextFormWidget(),
        ],
      ),
    );
  }
}