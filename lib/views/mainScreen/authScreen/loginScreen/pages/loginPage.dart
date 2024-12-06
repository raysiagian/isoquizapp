import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/loginScreen/widget/loginTextFormWidget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
        children: [
          // Bagian atas dengan ClipPath
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 400,
              color: LocalColorsStyle.primaryColor,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Text(
                        'Quiz App',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Image
                       SizedBox(height: 20),
                      // Gambar ilustrasi
                      Image.asset(
                        'assets/images/auth image.png',
                        height: 250,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bagian bawah dengan konten utama
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    LoginTextFormWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
