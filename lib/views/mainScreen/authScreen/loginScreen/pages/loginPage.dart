import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
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
      resizeToAvoidBottomInset: false, // Menonaktifkan perubahan layout saat keyboard muncul
      body: Stack(
        children: [
          // Bagian atas dengan ClipPath
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 340,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Gambar yang menimpa ClipPath
          Positioned(
            top: 100.0, 
            left: 0,    
            right: 0,   
            child: Image.asset(
              'assets/images/auth image.png',
              height: 250,
            ),
          ),

          // Bagian bawah dengan konten utama (Login Form Widget)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end, // Posisikan ke bawah
                children: [
                  // Menambahkan jarak
                  LoginTextFormWidget(), // Widget login
                   const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
