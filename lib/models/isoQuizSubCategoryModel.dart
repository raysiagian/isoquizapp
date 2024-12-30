class IsoQuizSubCategoryModel {
  final int id_quizsubCategory;
  final String title;
  // final String image;
  final int id_quizCategory;
  // final String explanation;

  IsoQuizSubCategoryModel({
    required this.id_quizsubCategory,
    required this.title,
    // required this.image,
    required this.id_quizCategory,
    // required this.explanation,
  });

  factory IsoQuizSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizSubCategoryModel(
      id_quizCategory: json["id_quizCategory"] as int,
      id_quizsubCategory: json["id_quizsubCategory"] as int,
      title: json["title"] as String,
      // image: json["imageCard"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_quizCategory': id_quizCategory,
    'id_quizsubCategory': id_quizsubCategory,
    'title': title,
    //'imageCard': imageCard,
  };

  @override
  String toString() {
    return 'IsoQuizCategoryModel{id_quizsubCategory: $id_quizsubCategory, id_quizCategory: $id_quizCategory, title: $title}';
  }

}