import 'package:movie_app/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity{

  CategoryModel({List<GenresModel>? genres});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <GenresModel>[];
      json['genres'].forEach((v) {
        genres!.add(GenresModel.fromJson(v));
      });
    }
  }
}

class GenresModel extends GenresEntity{


  GenresModel({int? id, String? name});

  GenresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
