import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';

abstract class MovieDetailsDomainRepo{

  Future<Either<Failures,MoviesEntity>> getMoreLike(String movieId);
}