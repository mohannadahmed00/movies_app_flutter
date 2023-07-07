import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/category_entity.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/movies_model.dart';

abstract class HomeDomainRepo {
  Future<Either<Failures,MoviesEntity>> getPopular();
  Future<Either<Failures,MoviesEntity>> getUpComing();
  Future<Either<Failures,MoviesEntity>> getTopRated();
  Future<Either<Failures,MoviesEntity>> searchMovies(String query);
  Future<Either<Failures,MoviesEntity>> getCategoryMovies(String categoryId);
  Future<Either<Failures,CategoryEntity>> getCategories();
  Future<void> addMovie(ResultsModel movie);
  Future<void> deleteMovie(ResultsModel movie);
  Future<QuerySnapshot<ResultsModel>> getMovies() ;
}
