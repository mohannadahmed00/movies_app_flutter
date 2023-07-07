import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/data/models/movies_model.dart';

import '../../../../core/error/failures.dart';

abstract class MovieDetailsDto{
  Future<Either<Failures,MoviesModel>> getMoreLike(String movieId);
}