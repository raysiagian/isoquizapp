import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';

class QuizOptionWidget extends StatefulWidget {
  const  QuizOptionWidget({
    Key? key,
    required this.option_A,
    required this.option_B,
    required this.option_C,
    required this.option_D,
    required this.option_E,
    required this.selectedOption,
    required this.onOptionSelected,
  }) : super(key: key);

  final String option_A;
  final String option_B;
  final String option_C;
  final String option_D;
  final String option_E;
  final String? selectedOption;
  final Function(String) onOptionSelected;

  @override
  State<QuizOptionWidget> createState() => _QuizOptionWidgetState();
}

class _QuizOptionWidgetState extends State<QuizOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOption(widget.option_A),
        _buildOption(widget.option_B),
        _buildOption(widget.option_C),
        _buildOption(widget.option_D),
        _buildOption(widget.option_E),
      ],
    );
  }

  
  Widget _buildOption(String option) {
    final isSelected = widget.selectedOption == option;
  
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
        onTap: () {
          widget.onOptionSelected(option);
        },
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

