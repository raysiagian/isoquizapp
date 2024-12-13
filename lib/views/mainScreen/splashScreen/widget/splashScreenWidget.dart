import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // Menambahkan alignment agar semua berada di tengah
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Untuk meratakan secara horizontal
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Vertikal tengah
                    children: [
                      Text(
                        'Q',
                        style: LocalTextStyle.textTheme.headlineMedium!.copyWith(
                          color: LocalColorsStyle.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'I',
                        style: LocalTextStyle.textTheme.headlineMedium!.copyWith(
                          color: LocalColorsStyle.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10), // Menambahkan jarak antar kolom
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Vertikal tengah
                    children: [
                      Text(
                        'U',
                        style: LocalTextStyle.textTheme.headlineMedium!.copyWith(
                          color: LocalColorsStyle.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Z',
                        style: LocalTextStyle.textTheme.headlineMedium!.copyWith(
                          color: LocalColorsStyle.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
         
          Text(
            'app',
            style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
