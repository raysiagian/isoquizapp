class IsoQuizQuestionModel {
  final int id_quizQuestion;
  final int id_quizsubCategory;
  final String question;
  final String option_A;
  final String option_B;
  final String option_C;
  final String option_D;
  final String option_E;
  final String correct_Answer;

  IsoQuizQuestionModel({
    required this.id_quizQuestion,
    required this.id_quizsubCategory,
    required this.question,
    required this.option_A,
    required this.option_B,
    required this.option_C,
    required this.option_D,
    required this.option_E,
    required this.correct_Answer,
  }) : options = {
    'option_A': option_A,
    'option_B': option_B,
    'option_C': option_C,
    'option_D': option_D,
    'option_E': option_E,
  };
  
  final Map<String, String> options;

  static final listIsoQuizQuestion = [
    IsoQuizQuestionModel(
      id_quizQuestion: 1, 
      id_quizsubCategory: 1, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A', 
    ),
    IsoQuizQuestionModel(
      id_quizQuestion: 3, 
      id_quizsubCategory: 1, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A' 
    ),
    IsoQuizQuestionModel(
      id_quizQuestion: 3, 
      id_quizsubCategory: 1, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A' 
    ),
    IsoQuizQuestionModel(
      id_quizQuestion: 4, 
      id_quizsubCategory: 1, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A' 
    ),
    IsoQuizQuestionModel(
      id_quizQuestion: 5, 
      id_quizsubCategory: 1, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A' 
    ),
    IsoQuizQuestionModel(
      id_quizQuestion: 6, 
      id_quizsubCategory: 2, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A' 
    ),
    IsoQuizQuestionModel(
      id_quizQuestion: 7, 
      id_quizsubCategory: 2, 
      question: 'Apa Itu Iso',
      option_A: 'Iso adalah A', 
      option_B: 'Iso adalah B', 
      option_C: 'Iso adalah C', 
      option_D: 'Iso adalah D', 
      option_E: 'Iso adalah E',
      correct_Answer: 'Iso adalah A' 
    ),
  ];

}