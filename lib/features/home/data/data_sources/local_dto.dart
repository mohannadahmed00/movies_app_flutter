import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/data/models/category_model.dart';

import 'package:movie_app/features/home/data/models/movies_model.dart';

import 'home_data_sources.dart';
class LocalDto implements HomeDataSources {
  @override
  Future<Either<Failures, MoviesModel>> getPopular() {
    // TODO: implement getPopular
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, MoviesModel>> getUpComing() {
    // TODO: implement getUpComing
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, MoviesModel>> getTopRated() {
    // TODO: implement getTopRated
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, MoviesModel>> searchMovies(String query) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, CategoryModel>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<void> addMovie(ResultsModel movie) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<QuerySnapshot<ResultsModel>> getMovies() {
    // TODO: implement getMovies
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMovie(ResultsModel movie) {
    // TODO: implement deleteMovie
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, MoviesModel>> getCategoryMovies(String categoryId) {
    // TODO: implement getCategoryMovies
    throw UnimplementedError();
  }

}
