import 'package:movie_app/features/home/domain/entities/movies_entity.dart';


class MoviesModel extends MoviesEntity {


  MoviesModel(
      {DatesModel? dates,
      int? page,
      List<ResultsModel>? results,
      int? totalPages,
      int? totalResults,});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? DatesModel.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = <ResultsModel>[];
      json['results'].forEach((v) {
        results!.add(ResultsModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }*/
}

class DatesModel extends DatesEntity {


  DatesModel({String? maximum, String? minimum});

  DatesModel.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maximum'] = maximum;
    data['minimum'] = minimum;
    return data;
  }*/
}

class ResultsModel extends ResultsEntity{


  ResultsModel(
      {bool? adult,
      String? backdropPath,
      List<int>? genreIds,
      String? id,
      String? originalLanguage,
      String? originalTitle,
      String? overview,
      double? popularity,
      String? posterPath,
      String? releaseDate,
      String? title,
      bool? video,
      String? voteAverage,
      int? voteCount,});

  ResultsModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'].toString();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'].toString();
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
