import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/quizCardWidget.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/totalScoreandRanks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
              children: [
                CircleAvatar(
                  radius: 20, // Ukuran lingkaran
                  backgroundImage: AssetImage('assets/images/male.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'username',
                      style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                     Text(
                      'email',
                      style: LocalTextStyle.textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          backgroundColor: LocalColorsStyle.primaryColor,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: screenWidth * 0.08, right: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Data lainnya di atas ListView.builder
              TotalScoreandRanksWidget(),
              const SizedBox(height: 20),
              // ListView.builder dengan shrinkWrap
              ListView.builder(
                shrinkWrap: true, // Membatasi tinggi sesuai konten
                physics: NeverScrollableScrollPhysics(), // Menghindari konflik scroll
                itemCount: IsoQuizCategoryModel.listIsoQuizCategory.length,
                itemBuilder: (context, index) {
                  final category = IsoQuizCategoryModel.listIsoQuizCategory[index];
                  return QuizCardWidget(
                    isoquizcategorymodel: category,
                  );
                },
              ),

              // Data lainnya di bawah ListView.builder
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
