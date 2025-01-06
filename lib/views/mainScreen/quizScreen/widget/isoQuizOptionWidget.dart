import 'package:flutter/material.dart';

class QuizOptionWidget extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOptionWidget({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 100.0,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            border: Border.all(
              width: 1,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}