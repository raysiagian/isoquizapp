import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/registerScreen/widget/chooseGenderWidget.dart';
import 'package:http/http.dart' as http;

class ChooseGenderPage extends StatefulWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final String password;

  const ChooseGenderPage({
    Key? key,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
  }) : super(key: key);
  @override
  State<ChooseGenderPage> createState() => _ChooseAvatarPageState();
}

class _ChooseAvatarPageState extends State<ChooseGenderPage> {
  String? selectedOption;

  @override

  Future<void> _registerUser() async {
    var genderValue = selectedOption == 'Wanita' ? 'female' : 'male';

    if (selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih jenis kelamin terlebih dahulu'),
        ),
      );
      return; // Hentikan eksekusi jika jenis kelamin belum dipilih
    }


    try {
      // Kirim data registrasi ke backend
      // print("Mempersiapkan request API...");
      var response = await http.post(
        // Uri.parse('http://10.0.2.2:8000/api/register'),
        Uri.parse(apiUrl + 'api/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': widget.username,
          'phoneNumber': widget.phoneNumber,
          'email': widget.email,
          'password': widget.password,
          'gender': genderValue,
        }),
      );


      if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Berhasil Mendaftar'),
          ));

          Navigator.pushNamed(
            context,
            AppRouteConstants.wrapper,
          );
      } else {
        print('Error: ${response.body}');
        // Gagal mendaftar, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.body}'),
        ));
      }

    } catch (e) {
      // Error lainnya, tangani sesuai kebutuhan Anda
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan. Silakan coba lagi nanti.'),
      ));
    }
  }


  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
              children: [
                Spacer(),
                Text(
                  'Pilih Jenis Kelamin',
                  style: LocalTextStyle.textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 80),
                ChooseGenderWidget(
                  maleAvatar: 'assets/images/Male Choose Gender.png',
                  femaleAvatar: 'assets/images/Female Choose Gender.png',
                  selectedOption: selectedOption,
                  onOptionSelected: (String option) {
                    setState(() {
                      selectedOption = option; // Perbarui opsi yang dipilih
                    });
                  },
                ),
                const SizedBox(height: 70.0),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _registerUser();
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRouteConstants.wrapper,
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LocalColorsStyle.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Terapkan',
                      style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Spacer(),
            ],),
        ),
      ),
    );
  }
}