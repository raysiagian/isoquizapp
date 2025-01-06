import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizQuestionModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizOptionWidget.dart';

class QuisQuestionWidget extends StatefulWidget {
  const QuisQuestionWidget({
    Key? key,
    required this.isoquizquestionmodel,
    required this.onAnswerSelected,
  }) : super(key: key);

  final IsoQuizQuestionModel isoquizquestionmodel;
  final ValueChanged<bool> onAnswerSelected;

  @override
  State<QuisQuestionWidget> createState() => _QuisQuestionWidgetState();
}

class _QuisQuestionWidgetState extends State<QuisQuestionWidget> {
  String? selectedOption;

  void _handleAnswerSelection(String selectedOption) {
    bool isCorrect = selectedOption == widget.isoquizquestionmodel.correct_Answer;
    widget.onAnswerSelected(isCorrect); // Notify the parent about the correct answer
    setState(() {
      this.selectedOption = selectedOption;
    });
  }

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
            ),
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
            ],
          ),
        ),
        // Option
        const SizedBox(height: 20),
        Column(
          children: [
            widget.isoquizquestionmodel.option_A,
            widget.isoquizquestionmodel.option_B,
            widget.isoquizquestionmodel.option_C,
            widget.isoquizquestionmodel.option_D,
            widget.isoquizquestionmodel.option_E,
          ]
              .map((option) => QuizOptionWidget(
                    option: option,
                    isSelected: selectedOption == option,
                    onTap: () => _handleAnswerSelection(option),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
