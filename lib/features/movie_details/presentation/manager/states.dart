import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/movies_entity.dart';

abstract class MovieDetailsStates {}

class MovieDetailsInitState extends MovieDetailsStates {}

class MovieDetailsChangeTabState extends MovieDetailsStates {}

class MovieDetailsGetSimilarLoadingState extends MovieDetailsStates {}

class MovieDetailsGetSimilarSuccessState extends MovieDetailsStates {
  MoviesEntity moviesEntity;

  MovieDetailsGetSimilarSuccessState(this.moviesEntity);
}

class MovieDetailsGetSimilarErrorState extends MovieDetailsStates {
  Failures failures;

  MovieDetailsGetSimilarErrorState(this.failures);
}


class MovieDetailsGetBookedLoadingState extends MovieDetailsStates {}
class MovieDetailsGetBookedSuccessState extends MovieDetailsStates {}
class MovieDetailsGetBookedErrorState extends MovieDetailsStates {}

