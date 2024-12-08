import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryGradePage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryTestPage.dart';

class QuizSubCategoryWrapperPage extends StatefulWidget {
  final IsoQuizCategoryModel quizCategory;
  final int id_quizCategory;
  final IsoQuizCategoryModel isoquizcategorymodel;


  const QuizSubCategoryWrapperPage({
    Key? key,
    required this.quizCategory,
    required this.id_quizCategory,
    required this.isoquizcategorymodel,
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
        appBar: AppBar(
          title: Text(
            widget.quizCategory.title, // Akses quizCategory dari widget
            style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Quiz',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Grade',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuizSubCategoryTestPage(id_quizCategory: widget.isoquizcategorymodel.id_quizCategory,),
            QuizSubCattegoryGradePage(),
          ],
        ),
      ),
    );
  }
}

         