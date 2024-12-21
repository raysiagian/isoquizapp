import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:http/http.dart' as http;

class LoginTextFormWidget extends StatefulWidget {
  const LoginTextFormWidget({super.key});

  @override
  State<LoginTextFormWidget> createState() => _LoginTextFormWidgetState();
}

class _LoginTextFormWidgetState extends State<LoginTextFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _emailFormatValidation(String email) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  Future<bool> _isEmailValid(String email) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl + 'api/checkEmail'),
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['status'];
      } else {
        throw Exception('Failed to check email');
      }
    } catch (e) {
      print('Error checking email: $e');
      throw Exception('Failed to check email');
    }
  }

  Future<void> _loginUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl + 'api/login'),
          body: jsonEncode({
            'email': _emailController.text,
            'password': _passwordController.text,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          // final Map<String, dynamic> data = json.decode(response.body);
          final responseData = json.decode(response.body);
          final is_Active = responseData['is_Active'];
          // print(data); // Debug data
          //data['user'] != null && data['user']['is_Active'] == 1
          if (is_Active == 1 || is_Active == '1') {
            Navigator.pushNamed(context, AppRouteConstants.wrapper);
          } else {
            _showSnackBar(context, 'Akun tidak aktif. Hubungi admin.', Colors.red);
          }
        } else {
          _showSnackBar(context, 'Email atau password salah.', Colors.red);
        }
      } catch (e) {
        _showSnackBar(context, 'Terjadi kesalahan, coba lagi.', Colors.red);
      }
    }
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Form Field
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                if (!_emailFormatValidation(value)) {
                  return 'Format email tidak valid';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Email',
                labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20.0),
            
            // Password Form Field
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                if (value.length < 6) {
                  return 'Password minimal 6 karakter';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Password',
                labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20.0),
            
            // Login Button
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _loginUser(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: LocalColorsStyle.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            
            // Redirect to Register Page
            Center(child: Text("Belum punya akun?")),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, AppRouteConstants.registerPage),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
      ),
    );
  }
}
