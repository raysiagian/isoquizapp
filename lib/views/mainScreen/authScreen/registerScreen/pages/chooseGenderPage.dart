import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/authScreen/registerScreen/widget/chooseGenderWidget.dart';

class ChooseGenderPage extends StatefulWidget {
  const ChooseGenderPage({super.key});

  @override
  State<ChooseGenderPage> createState() => _ChooseAvatarPageState();
}

class _ChooseAvatarPageState extends State<ChooseGenderPage> {
  String? selectedOption;
  @override
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
                  maleAvatar: 'assets/images/male.png',
                  femaleAvatar: 'assets/images/female.png',
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