class IsoQuizMaterialModel {
  final int id_quizMaterial;
  final int id_quizSubCategory;
  final String title;
  final String data;

  IsoQuizMaterialModel({
    required this.id_quizMaterial,
    required this.id_quizSubCategory,
    required this.title,
    required this.data,
  });

   factory IsoQuizMaterialModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizMaterialModel(
      id_quizMaterial: json["id_quizMaterial"] as int,
      id_quizSubCategory: json["id_quizSubCategory"] as int,
      title: json["title"] as String,
      data: json["data"] as String,
      // image: json["imageCard"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_quizMaterial': id_quizMaterial,
    'id_quizSubCategory': id_quizSubCategory, 
    'title': title,
    'data': data,
    //'imageCard': imageCard,
  };

  @override
  String toString() {
    return 'IsoQuizCategoryModel{id_quizSubCategory: $id_quizSubCategory, id_quizMaterial: $id_quizMaterial, title: $title, data: $data}';
  }
}