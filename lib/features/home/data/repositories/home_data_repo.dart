import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/data/models/category_model.dart';
import 'package:movie_app/features/home/data/models/movies_model.dart';
import '../../domain/repositories/home_domain_repo.dart';
import '../data_sources/home_data_sources.dart';

class HomeDataRepo implements HomeDomainRepo {
  HomeDataSources homeDataSources;

  HomeDataRepo(this.homeDataSources);

  @override
  Future<Either<Failures, MoviesModel>> getPopular()=>homeDataSources.getPopular();

  @override
  Future<Either<Failures, MoviesModel>> getUpComing()=>homeDataSources.getUpComing();

  @override
  Future<Either<Failures, MoviesModel>> getTopRated()=>homeDataSources.getTopRated();

  @override
  Future<Either<Failures, MoviesModel>> searchMovies(String query)=>homeDataSources.searchMovies(query);

  @override
  Future<Either<Failures,CategoryModel>> getCategories()=>homeDataSources.getCategories();

  @override
  Future<void> addMovie(ResultsModel movie) =>homeDataSources.addMovie(movie);

  @override
  Future<void> deleteMovie(ResultsModel movie) =>homeDataSources.deleteMovie(movie);

  @override
  Future<QuerySnapshot<ResultsModel>> getMovies() =>homeDataSources.getMovies();

  @override
  Future<Either<Failures, MoviesModel>> getCategoryMovies(String categoryId) =>homeDataSources.getCategoryMovies(categoryId);




}
