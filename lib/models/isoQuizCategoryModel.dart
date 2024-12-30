class IsoQuizCategoryModel {
  final int id_quizCategory;
  final String title;
  // final String image;
  // final String explanation;

  IsoQuizCategoryModel({
    required this.id_quizCategory,
    required this.title,
    // required this.image,
    // required this.explanation,
  });

  factory IsoQuizCategoryModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizCategoryModel(
      id_quizCategory: json["id_quizCategory"] as int,
      title: json["title"] as String,
      // image: json["imageCard"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_quizCategory': id_quizCategory,
    'title': title,
    //'imageCard': imageCard,
  };

  @override
  String toString() {
    return 'IsoQuizCategoryModel{id_quizCategory: $id_quizCategory, title: $title}';
  }

  //  static final listIsoQuizCategory = [
  //   IsoQuizCategoryModel(
  //     id_quizCategory: 1, 
  //     title: 'Bahasa',
  //     image:'1',
  //     // explanation: 'ISO standarization on computer'
  //   ),
  //   IsoQuizCategoryModel(
  //     id_quizCategory: 2, 
  //     title: 'Matematika',
  //     image:'2',
  //     // explanation: 'ISO standarization on computer'
  //   ),
  //   IsoQuizCategoryModel(
  //     id_quizCategory: 3, 
  //     title: 'Ips',
  //     image:'3',
  //     // explanation: 'ISO standarization on computer'
  //   ),
  // ];
}