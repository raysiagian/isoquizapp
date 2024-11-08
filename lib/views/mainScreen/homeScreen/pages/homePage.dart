import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/anexCardWidget.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/quizCardWidget.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/scoreChartWidget.dart';

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
            // Content Here
            children: [
              ScoreChartWidget(),
              // const SizedBox(height: 20),
              // AnexCardWidget(),
              const SizedBox(height: 20),
              QuizCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}