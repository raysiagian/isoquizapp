import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:http/http.dart' as http;


// class RegisterTextFormWidget extends StatefulWidget {
//   const RegisterTextFormWidget({super.key});

//   @override
//   State<RegisterTextFormWidget> createState() => _RegisterTextFromWidgetState();
// }

// class _RegisterTextFromWidgetState extends State<RegisterTextFormWidget> {
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool _emailFormatValidation(String email) {
//     String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//     RegExp regExp = RegExp(emailRegex);
//     return regExp.hasMatch(email);
//   }

//     bool _phoneNumberFormatValidation(String phoneNumber) {
//     String phoneNumberRegex = r'^[0-9]+$';
//     RegExp regExp = RegExp(phoneNumberRegex);
//     return regExp.hasMatch(phoneNumber);
//   }

//     Future<bool> _isEmailAvailable(String email) async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl + 'api/checkEmail'),
//         body: jsonEncode({'email': email}),
//         headers: {'Content-Type': 'application/json'},
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final bool isAvailable = data['status'];
//         return isAvailable;
//       } else {
//         throw Exception('Failed to check email availability');
//       }
//     } catch (e) {
//       print('Error checking email availability: $e');
//       throw Exception('Failed to check email availability');
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * 0.05,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start, // Sejajarkan ke kiri
//         mainAxisAlignment: MainAxisAlignment.start,   // Mulai dari atas
//         children: [
//           // Form Username
//           TextFormField(
//             controller: _userNameController,
//             validator: (value){
//               if (value == null || value.isEmpty){
//                 return 'Usernama tdak boleh kosong';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//               labelText: 'Username',
//               labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20.0),

//           // Form Email
//           TextFormField(
//             controller: _emailController,
//             validator: (value) {
//               if (value == null || value.isEmpty){
//                 return 'Email tidak boleh kosong';
//               }
//               if(!_emailFormatValidation(value)){
//                 return 'Email tidak Valid';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//               labelText: 'Email',
//               labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20.0),

//           // Form Phone Number
//           TextFormField(
//             controller: _phoneNumberController,
//             validator: (value){
//                if (value == null || value.isEmpty){
//                 return 'Nomor Telephone tdak boleh kosong';
//               }
//                 if(!_phoneNumberFormatValidation(value)){
//                 return 'Masukkan format Nomor yang benar';
//               }
//               if (value.length < 10) {
//                 return 'Nomor Telephone tidak Valid';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//               labelText: 'Phone Number',
//               labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20.0),

//           // Form Password
//           TextFormField(
//             controller: _passwordController,
//             validator: (value){
//               if (value == null || value.isEmpty) {
//                 return 'Password tidak boleh kosong';
//               }
//               if (value.length < 8) {
//                 return 'Panjangan password minimal 8 karakter';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//               labelText: 'Password',
//               labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
//                 color: Colors.black,
//               ),
//               suffixIcon: Icon(Icons.visibility),
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           const SizedBox(height: 20.0),
//           // Login Button
//           SizedBox(
//             height: 50,
//             width: double.infinity,
//             child: ElevatedButton(
// onPressed: () async {
//   bool isValid = true;
//   String errorMessage = '';

//   // Validasi form
//   if (_formKey.currentState?.validate() != true) {
//     isValid = false;
//     errorMessage += 'Mohon lengkapi semua field yang wajib diisi.\n';
//   }

//   // Validasi email format
//   if (!_emailFormatValidation(_emailController.text)) {
//     isValid = false;
//     errorMessage += 'Email tidak valid.\n';
//   }

//   // Validasi format nomor telepon
//   if (!_phoneNumberFormatValidation(_phoneNumberController.text)) {
//     isValid = false;
//     errorMessage += 'Masukkan format Nomor yang benar.\n';
//   }

//   // Validasi panjang nomor telepon
//   if (_phoneNumberController.text.length < 10) {
//     isValid = false;
//     errorMessage += 'Nomor Telepon harus lebih dari 9 digit.\n';
//   }

//   // Validasi panjang password
//   if (_passwordController.text.length < 8) {
//     isValid = false;
//     errorMessage += 'Password harus minimal 8 karakter.\n';
//   }

//   // Jika form dan email format valid, lanjutkan dengan validasi server
//   if (isValid) {
//     try {
//       bool isEmailAvailable = await _isEmailAvailable(_emailController.text);
//       if (!isEmailAvailable) {
//         isValid = false;
//         errorMessage += 'Email sudah terdaftar.\n';
//       }
//     } catch (e) {
//       isValid = false;
//       errorMessage += 'Gagal memeriksa email: $e\n';
//     }
//   }

//   // Jika ada error, tampilkan pesan kesalahan satu per satu
//   if (!isValid) {
//     // Pisahkan errorMessage menjadi baris yang lebih kecil
//     List<String> errorMessages = errorMessage.trim().split('\n');

//     // Tampilkan pesan kesalahan sesuai urutannya
//     for (int i = 0; i < errorMessages.length; i++) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(errorMessages[i])),
//       );
//       await Future.delayed(Duration(seconds: 1)); // Jeda 1 detik antar pesan
//     }
//     return;
//   }

//   // Jika validasi berhasil, navigasi ke halaman berikutnya
//   Navigator.pushNamed(
//     context,
//     AppRouteConstants.genderPage,
//     arguments: {
//       'userName': _userNameController.text,
//       'email': _emailController.text,
//       'phoneNumber': _phoneNumberController.text,
//       'password': _passwordController.text,
//     },
//   );
// },


//               style: ElevatedButton.styleFrom(
//                 backgroundColor: LocalColorsStyle.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               child: Text(
//                 'Daftar',
//                 style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20.0),
//           const Center(child: Text("Sudah punya akun ?")),
//           const SizedBox(height: 20.0),

//           // Sign Up Button
//           SizedBox(
//             height: 50,
//             width: double.infinity,
//             child: OutlinedButton(
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   AppRouteConstants.loginPage,
//                 );
//               },
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               child: Text(
//                 'Login',
//                 style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
//                   color: LocalColorsStyle.primaryColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:http/http.dart' as http;

class RegisterTextFormWidget extends StatefulWidget {
  const RegisterTextFormWidget({super.key});

  @override
  State<RegisterTextFormWidget> createState() => _RegisterTextFromWidgetState();
}

class _RegisterTextFromWidgetState extends State<RegisterTextFormWidget> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _emailFormatValidation(String email) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  bool _phoneNumberFormatValidation(String phoneNumber) {
    String phoneNumberRegex = r'^[0-9]+$';
    RegExp regExp = RegExp(phoneNumberRegex);
    return regExp.hasMatch(phoneNumber);
  }

  Future<bool> _isEmailAvailable(String email) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl + 'api/checkEmail'),
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool isAvailable = data['status'];
        return isAvailable;
      } else {
        throw Exception('Failed to check email availability');
      }
    } catch (e) {
      print('Error checking email availability: $e');
      throw Exception('Failed to check email availability');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Form Username
          TextFormField(
            controller: _userNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username tidak boleh kosong';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Username',
              labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Form Email
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!_emailFormatValidation(value)) {
                return 'Email tidak valid';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Email',
              labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Form Phone Number
          TextFormField(
            controller: _phoneNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nomor Telephone tidak boleh kosong';
              }
              if (!_phoneNumberFormatValidation(value)) {
                return 'Masukkan format Nomor yang benar';
              }
              if (value.length < 10) {
                return 'Nomor Telephone tidak Valid';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Phone Number',
              labelStyle: LocalTextStyle.textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Form Password
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 8) {
                return 'Panjang password minimal 8 karakter';
              }
              return null;
            },
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
          const SizedBox(height: 20.0),

          // Register Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                bool isValid = true;
                String errorMessage = '';

                // Step 1: Check if all required fields are filled
                if (_userNameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _phoneNumberController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  isValid = false;
                  errorMessage = 'Mohon lengkapi semua field yang wajib diisi.';
                }

                // Step 2: Validate email format
                if (isValid && !_emailFormatValidation(_emailController.text)) {
                  isValid = false;
                  errorMessage = 'Email tidak valid.';
                }

                // Step 3: Validate phone number format
                if (isValid && !_phoneNumberFormatValidation(_phoneNumberController.text)) {
                  isValid = false;
                  errorMessage = 'Masukkan format Nomor yang benar.';
                }

                // Step 4: Validate phone number length
                if (isValid && _phoneNumberController.text.length < 10) {
                  isValid = false;
                  errorMessage = 'Nomor Telepon harus lebih dari 9 digit.';
                }

                // Step 5: Validate password length
                if (isValid && _passwordController.text.length < 8) {
                  isValid = false;
                  errorMessage = 'Password harus minimal 8 karakter.';
                }

                // Step 6: Check email availability (if previous checks are valid)
                if (isValid) {
                  try {
                    bool isEmailAvailable = await _isEmailAvailable(_emailController.text);
                    if (!isEmailAvailable) {
                      isValid = false;
                      errorMessage = 'Email sudah terdaftar.';
                    }
                  } catch (e) {
                    isValid = false;
                    errorMessage = 'Gagal memeriksa email: $e';
                  }
                }

                // Step 7: If validation failed, show the error message
                if (!isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                } else {
                  // Proceed to the next screen if all validations pass
                   Navigator.pushNamed(
                    context,
                    AppRouteConstants.genderPage,
                    arguments: {
                      'userName': _userNameController.text,
                      'email': _emailController.text,
                      'phoneNumber': _phoneNumberController.text,
                      'password': _passwordController.text,
                    },
                  );
                }
              },
             style: ElevatedButton.styleFrom(
                backgroundColor: LocalColorsStyle.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Daftar',
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Center(child: Text("Sudah punya akun ?")),
          const SizedBox(height: 20.0),

          // Sign Up Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouteConstants.loginPage,
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Login',
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