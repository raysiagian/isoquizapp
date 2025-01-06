class IsoQuizSubCategoryGradeModel {
  final int id_quizCategory;  // Menambahkan id_quizCategory
  final int id_quizSubCategory;
  final String subCategoryTitle;
  final int highestScore;

  IsoQuizSubCategoryGradeModel({
    required this.id_quizCategory,  // Menambahkan parameter ini
    required this.id_quizSubCategory,  // Menambahkan id_quizSubCategory
    required this.subCategoryTitle,
    required this.highestScore,
  });

  factory IsoQuizSubCategoryGradeModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizSubCategoryGradeModel(
      id_quizCategory: json['id_quizCategory'],  // Menambahkan id_quizCategory
      id_quizSubCategory: json['id_quizSubCategory'],  // Menambahkan id_quizSubCategory
      subCategoryTitle: json['subCategoryTitle'],
      highestScore: _parseToInt(json['highestScore']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_quizCategory': id_quizCategory,  // Menambahkan id_quizCategory
      'id_quizSubCategory': id_quizSubCategory,  // Menambahkan id_quizSubCategory
      'subCategoryTitle': subCategoryTitle,
      'highestScore': highestScore,
    };
  }

  static int _parseToInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is int) {
      return value;
    } else {
      return 0;
    }
  }

}