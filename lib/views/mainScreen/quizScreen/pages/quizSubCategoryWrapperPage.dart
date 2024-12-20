import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryGradePage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryTestPage.dart';

class QuizSubCategoryWrapperPage extends StatefulWidget {
  final IsoQuizCategoryModel isoquizcategorymodel;
  // final int id_quizCategory;

  const QuizSubCategoryWrapperPage({
    Key? key,
    required this.isoquizcategorymodel,
    // required this.id_quizCategory,
  }) : super(key: key);

  @override
  State<QuizSubCategoryWrapperPage> createState() =>
      _QuizSubCategoryWrapperPageState();
}

class _QuizSubCategoryWrapperPageState
    extends State<QuizSubCategoryWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120), // Tinggi AppBar
          child: Stack(
            children: [
              // Latar belakang dekoratif
              Container(
                decoration: const BoxDecoration(
                  color: LocalColorsStyle.primaryColor,                  
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
              // Elemen dekoratif
              Positioned(
                top: 20,
                right: 70,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 20,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 40,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                top: 75,
                right: 80,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                ),
              ),
              // Konten AppBar
              AppBar(
                title: Text(
                  widget.isoquizcategorymodel.title,
                  style: LocalTextStyle.textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white, // Warna panah kembali
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                bottom: const TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        'Quiz',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Grade',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuizSubCategoryTestPage(
              id_quizCategory: widget.isoquizcategorymodel.id_quizCategory,
              isoquizcategorymodel: widget.isoquizcategorymodel,
            ),
            QuizSubCategoryGradePage(),
          ],
        ),
      ),
    );
  }
}
