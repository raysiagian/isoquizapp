class IsoQuizQuestionModel {
  final int id_quizQuestion;
  final int id_quizSubCategory;
  final String question;
  final String option_A;
  final String option_B;
  final String option_C;
  final String option_D;
  final String option_E;
  final String correct_Answer;

  IsoQuizQuestionModel({
    required this.id_quizQuestion,
    required this.id_quizSubCategory,
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


  factory IsoQuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizQuestionModel(
      id_quizQuestion: json["id_quizQuestion"] as int,
      id_quizSubCategory: json["id_quizSubCategory"] as int,
      question: json["question"] as String,
      option_A: json["option_A"] as String,
      option_B: json["option_B"] as String,
      option_C: json["option_C"] as String,
      option_D: json["option_D"] as String,
      option_E: json["option_E"] as String,
      correct_Answer: json["correct_Answer"] as String,
      // image: json["imageCard"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_quizQuestion': id_quizQuestion,
    'id_quizSubCategory': id_quizSubCategory,
    'question': question,
    'option_A': option_A,
    'option_B': option_B,
    'option_C': option_C,
    'option_D': option_D,
    'option_E': option_E,
    'correct_Answer': correct_Answer,
    //'imageCard': imageCard,
  };

  @override
  String toString() {
    return 'IsoQuizQuestionModel{id_quizSubCategory: $id_quizSubCategory, id_quizQuestion: $id_quizQuestion, question: $question, option_A: $option_A, option_B: $option_B, option_C: $option_C, option_D: $option_D, option_E $option_E, correct_Answer: $correct_Answer}';
  }

}