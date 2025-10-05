import 'package:zajel_hub/core/entities/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;
  final String nameAr;
  final String? imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.nameAr,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      nameAr: json['nameAr'],
      imageUrl: json['imageUrl'],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      nameAr: nameAr,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'imageUrl': imageUrl,
    };
  }
}
