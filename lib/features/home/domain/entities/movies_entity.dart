import 'package:equatable/equatable.dart';

class MoviesEntity {
  DatesEntity? dates;
  int? page;
  List<ResultsEntity>? results;
  int? totalPages;
  int? totalResults;

  MoviesEntity(
      {this.dates,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults});

  MoviesEntity.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? DatesEntity.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = <ResultsEntity>[];
      json['results'].forEach((v) {
        results!.add(ResultsEntity.fromJson(v));
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

class DatesEntity {
  String? maximum;
  String? minimum;

  DatesEntity({this.maximum, this.minimum});

  DatesEntity.fromJson(Map<String, dynamic> json) {
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

class ResultsEntity extends Equatable{
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  String? voteAverage;
  int? voteCount;

  ResultsEntity(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  ResultsEntity.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount
  ];

  /*Map<String, dynamic> toJson() {
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
  }*/
}
