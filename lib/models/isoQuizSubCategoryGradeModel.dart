class IsoQuizSubCategoryGradeModel {
  final int id_quizCategory;
  final int id_quizSubCategory;
  final int score_Quiz; // Make sure this field is defined

  IsoQuizSubCategoryGradeModel({
    required this.id_quizCategory,
    required this.id_quizSubCategory,
    required this.score_Quiz,
  });

  factory IsoQuizSubCategoryGradeModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizSubCategoryGradeModel(
      id_quizCategory: json["id_quizCategory"] as int,
      id_quizSubCategory: json["id_quizSubCategory"] as int,
      score_Quiz: json["score_Quiz"] as int, // Ensure this field is in the response
    );
  }

  @override
  String toString() {
    return 'IsoQuizSubCategoryGradeModel{id_quizCategory: $id_quizCategory, id_quizSubCategory: $id_quizSubCategory, score_Quiz: $score_Quiz}';
  }
}
