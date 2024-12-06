import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/quizCardWidget.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Welcome',
          style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Data lainnya di atas ListView.builder
              const SizedBox(height: 20),

              // Tambahkan widget statis atau dinamis lainnya di sini

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
