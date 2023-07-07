import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/data/models/category_model.dart';
import 'package:movie_app/features/home/data/models/movies_model.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/utils/constants.dart';
import 'home_data_sources.dart';



class RemoteDto implements HomeDataSources {
  Dio dio = Dio();

  @override
  Future<Either<Failures, MoviesModel>> getPopular() async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.popular}",
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      MoviesModel model = MoviesModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, MoviesModel>> getUpComing() async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.upcoming}",
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      MoviesModel model = MoviesModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, MoviesModel>> getTopRated() async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.topRated}",
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      MoviesModel model = MoviesModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, MoviesModel>> searchMovies(String query) async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.search}",
        queryParameters: {"query":query},
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      MoviesModel model = MoviesModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, CategoryModel>> getCategories() async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.category}",
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      CategoryModel model = CategoryModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, MoviesModel>> getCategoryMovies(String categoryId) async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.discover}",
        queryParameters: {
          "with_genres":categoryId
        },
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      MoviesModel model = MoviesModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }

  CollectionReference<ResultsModel> getMoviesCollection() {
    return FirebaseFirestore.instance
        .collection(Constants.MOVIE_COLLECTION_NAME)
        .withConverter<ResultsModel>(fromFirestore: (snapshot, _) {
      return ResultsModel.fromJson(snapshot.data()!);
    }, toFirestore: (movie, _) {
      return movie.toJson();
    });
  }

  @override
  Future<void> addMovie(ResultsModel movie) {
    var collection = getMoviesCollection();
    var docRef = collection.doc(movie.id);
    return docRef.set(movie);
  }

  @override
  Future<void> deleteMovie(ResultsModel movie) {
    var collection = getMoviesCollection();
    var docRef = collection.doc(movie.id);
    return docRef.delete();
  }


  @override
  Future<QuerySnapshot<ResultsModel>> getMovies() {
    //return getTasksCollection().snapshots(); // real-time read
    return getMoviesCollection().get(); //one-time read
  }



}
