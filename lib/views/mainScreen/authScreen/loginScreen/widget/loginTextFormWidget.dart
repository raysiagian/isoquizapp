import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class LoginTextFormWidget extends StatefulWidget {
  const LoginTextFormWidget({super.key});

  @override
  _LoginTextFormWidgetState createState() => _LoginTextFormWidgetState();
}

class _LoginTextFormWidgetState extends State<LoginTextFormWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Sejajarkan ke kiri
        mainAxisAlignment: MainAxisAlignment.start,   // Mulai dari atas
        children: [
          // Form Email
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Email',
              labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Form Password
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Password',
              labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
              suffixIcon: Icon(Icons.visibility),
            ),
          ),
          const SizedBox(height: 10.0),

          // Row untuk Checkbox dan Teks
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              const Text('Ingat Saya'),
            ],
          ),
          const SizedBox(height: 20.0),

          // Login Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // print('Button has been pressed!');
                Navigator.pushNamed(
                  context,
                  AppRouteConstants.wrapper,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LocalColorsStyle.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Login',
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Center(child: Text("Belum punya akun ?")),
          const SizedBox(height: 20.0),

          // Sign Up Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouteConstants.registerPage,
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Daftar',
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: LocalColorsStyle.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
