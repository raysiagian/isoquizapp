import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_iso_app/views/mainScreen/wrapper/pages/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginTextFormWidget extends StatefulWidget {
  final ValueChanged<String> onLoginSuccess;

  const LoginTextFormWidget({ Key? key,
    required this.onLoginSuccess,
  }) : super(key: key);

  @override
  State<LoginTextFormWidget> createState() => _LoginTextFormWidgetState();
}

class _LoginTextFormWidgetState extends State<LoginTextFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  bool isChecked = false;


  Future<void> _saveToken(String token) async {
    await storage.write(key: 'access_token', value: token);
    print('Token saved: $token');
  }

  Future<void> _loginUser(BuildContext context) async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'), // URL login API
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    // Periksa jika status kode adalah 200 OK
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Cek apakah data respons mengandung 'is_Active'
      if (responseData.containsKey('is_Active') &&
          (responseData['is_Active'] == 1 || responseData['is_Active'] == '1')) {
        final token = responseData['token'];
        await _saveToken(token);  // Simpan token

        // Jika checkbox "remember me" dicentang, simpan refresh_token
        if (isChecked) {
          final refreshToken = responseData['refresh_token'];
          await storage.write(key: 'refresh_token', value: refreshToken);
        }

        // Navigasi ke halaman utama setelah login berhasil
        if (mounted) {
          print(json); 
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Wrapper()),
          );
        }
      } else {
        _showSnackBar(context, 'Akun tidak aktif. Hubungi admin.', Colors.red);
      }
    } else {
      // Menangani status selain 200 OK
      _showSnackBar(context, 'Email atau password salah.', Colors.red);
    }
  } catch (e) {
    // Tangani kesalahan saat pengiriman request atau parsing respons
    print('Login error: $e');
    _showSnackBar(context, 'Terjadi kesalahan server. Silakan coba lagi.', Colors.red);
  }
}


  // Future<void> _loginUser(BuildContext context) async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }

  //   try {
  //     final response = await http.post(
  //       // Uri.parse(apiUrl + 'api/login'),
  //       Uri.parse('http://10.0.2.2:8000/api/login'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'email': _emailController.text,
  //         'password': _passwordController.text,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
        
  //       if (responseData.containsKey('is_Active') &&
  //           (responseData['is_Active'] == 1 || responseData['is_Active'] == '1')) {
  //         final token = responseData['token'];
  //         await _saveToken(token);

  //         if (isChecked) {
  //           final refreshToken = responseData['refresh_token'];
  //           await storage.write(key: 'refresh_token', value: refreshToken);
  //         }

  //         if (mounted) {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => Wrapper()),
  //           );
  //         }
  //       } else {
  //         _showSnackBar(context, 'Akun tidak aktif. Hubungi admin.', Colors.red);
  //       }
  //     } else {
  //       _showSnackBar(context, 'Email atau password salah.', Colors.red);
  //     }
  //   } catch (e) {
  //     print('Login error: $e');
  //     _showSnackBar(context, 'Terjadi kesalahan server. Silakan coba lagi.', Colors.red);
  //   }
  // }



  bool _emailFormatValidation(String email) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  Future<String?> _getToken() async {
    return await storage.read(key: 'access_token');  // Using FlutterSecureStorage
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }


  Future<void> _saveUser(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userData));
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

            const SizedBox(height: 10.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Checkbox(
                //   value: isChecked,
                //   onChanged: (bool? value) {
                //     setState(() {
                //       isChecked = value ?? false;
                //     });
                //   },
                // ),
                //   const Text('Ingat Saya'),
                 Checkbox(
                  value: isChecked,
                  onChanged: (value) => setState(() => isChecked = value!),
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
