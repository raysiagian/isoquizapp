import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizQuestionModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class QuisQuestionWidget extends StatefulWidget {
  const QuisQuestionWidget({
    Key? key,
    required this.isoquizquestionmodel,
  }): super(key: key);

  final IsoQuizQuestionModel isoquizquestionmodel;


  @override
  State<QuisQuestionWidget> createState() => _QuisQuestionWidgetState();
}

class _QuisQuestionWidgetState extends State<QuisQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isoquizquestionmodel.question,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],),
          ),
        Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isoquizquestionmodel.option_A,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],),
          ),
        const SizedBox(height: 10),
                Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isoquizquestionmodel.option_B,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],),
          ),
          const SizedBox(height: 10),
          Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isoquizquestionmodel.option_C,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],),
          ),
           const SizedBox(height: 10),
                Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isoquizquestionmodel.option_D,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],),
          ),
           const SizedBox(height: 10),
                Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isoquizquestionmodel.option_E,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],),
          ),
    ]);
  }
}