// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecipeModel {
  final int id;
  final String title;
  final String imageUrl;
  RecipeModel({required this.id, required this.title, required this.imageUrl});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
    );
  }
}
