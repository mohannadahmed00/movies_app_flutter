import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/data/models/category_model.dart';

import '../../../../core/error/failures.dart';
import '../models/movies_model.dart';

abstract class HomeDataSources {
  Future<Either<Failures, MoviesModel>> getPopular();
  Future<Either<Failures, MoviesModel>> getUpComing();
  Future<Either<Failures, MoviesModel>> getTopRated();
  Future<Either<Failures, MoviesModel>> searchMovies(String query);
  Future<Either<Failures, MoviesModel>> getCategoryMovies(String categoryId);
  Future<Either<Failures, CategoryModel>> getCategories();
  Future<void> addMovie(ResultsModel movie);
  Future<void> deleteMovie(ResultsModel movie);
  Future<QuerySnapshot<ResultsModel>> getMovies() ;
}
