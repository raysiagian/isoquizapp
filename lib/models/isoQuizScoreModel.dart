class IsoQuizScoreModel {
  final int id_scoreQuiz;
  final int id_User;
  final int id_quizsubCategory;
  final int id_quizCategory;
  final int score_Quiz;

  IsoQuizScoreModel({
    required this.id_scoreQuiz,
    required this.id_User,
    required this.id_quizsubCategory,
    required this.id_quizCategory,
    required this.score_Quiz,
  });

  factory IsoQuizScoreModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizScoreModel(
      id_scoreQuiz: json["id_scoreQuiz"] as int,
      id_User: json["id_User"] as int,
      id_quizCategory: json["id_quizCategory"] as int,
      id_quizsubCategory: json["id_quizsubCategory"] as int,
      score_Quiz: json["score_Quiz"] != null ? json["score_Quiz"] as int : 0, // Penanganan jika score_Quiz bisa null
    );
  }

  @override
  String toString() {
    return 'IsoQuizScoreModel{id_quizCategory: $id_quizCategory, id_quizsubCategory: $id_quizsubCategory, id_scoreQuiz: $id_scoreQuiz, id_User: $id_User, score_Quiz: $score_Quiz}';
  }
}
