import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/domain/entities/category_entity.dart';
import '../../domain/entities/movies_entity.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeChangeTabState extends HomeStates {}

class HomeGetPopularLoadingState extends HomeStates {}
class HomeGetPopularSuccessState extends HomeStates {
  MoviesEntity moviesEntity;

  HomeGetPopularSuccessState(this.moviesEntity);
}
class HomeGetPopularErrorState extends HomeStates {
  Failures failures;

  HomeGetPopularErrorState(this.failures);
}

class HomeGetUpComingLoadingState extends HomeStates {}
class HomeGetUpComingSuccessState extends HomeStates {
  MoviesEntity moviesEntity;

  HomeGetUpComingSuccessState(this.moviesEntity);
}
class HomeGetUpComingErrorState extends HomeStates {
  Failures failures;

  HomeGetUpComingErrorState(this.failures);
}

class HomeGetTopRatedLoadingState extends HomeStates {}
class HomeGetTopRatedSuccessState extends HomeStates {
  MoviesEntity moviesEntity;

  HomeGetTopRatedSuccessState(this.moviesEntity);
}
class HomeGetTopRatedErrorState extends HomeStates {
  Failures failures;

  HomeGetTopRatedErrorState(this.failures);
}

class HomeSearchLoadingState extends HomeStates {}
class HomeSearchClearState extends HomeStates {}
class HomeSearchSuccessState extends HomeStates {
  MoviesEntity moviesEntity;

  HomeSearchSuccessState(this.moviesEntity);
}
class HomeSearchErrorState extends HomeStates {
  Failures failures;

  HomeSearchErrorState(this.failures);
}

class HomeGetCategoriesLoadingState extends HomeStates {}
class HomeGetCategoriesSuccessState extends HomeStates {
  CategoryEntity categoryEntity;

  HomeGetCategoriesSuccessState(this.categoryEntity);
}
class HomeGetCategoriesErrorState extends HomeStates {
  Failures failures;

  HomeGetCategoriesErrorState(this.failures);
}

class HomeGetCategoryMoviesLoadingState extends HomeStates {}
class HomeGetCategoryMoviesSuccessState extends HomeStates {
  MoviesEntity moviesEntity;

  HomeGetCategoryMoviesSuccessState(this.moviesEntity);
}
class HomeGetCategoryMoviesErrorState extends HomeStates {
  Failures failures;

  HomeGetCategoryMoviesErrorState(this.failures);
}


class HomeGetBookedLoadingState extends HomeStates {}
class HomeGetBookedSuccessState extends HomeStates {}
class HomeGetBookedErrorState extends HomeStates {}

class HomeDeleteBookedLoadingState extends HomeStates {}
class HomeDeleteBookedSuccessState extends HomeStates {}
class HomeDeleteBookedErrorState extends HomeStates {}
