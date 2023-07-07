import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie_details/data/repositories/movie_details_data_repo.dart';
import 'package:movie_app/features/movie_details/domain/repositories/movie_details_domain_repo.dart';
import 'package:movie_app/features/movie_details/presentation/manager/states.dart';

import '../../../home/data/data_sources/home_data_sources.dart';
import '../../../home/data/models/movies_model.dart';
import '../../../home/data/repositories/home_data_repo.dart';
import '../../../home/domain/entities/category_entity.dart';
import '../../../home/domain/entities/movies_entity.dart';
import '../../../home/domain/repositories/home_domain_repo.dart';
import '../../../home/domain/use_cases/book_movie_use_case.dart';
import '../../../home/domain/use_cases/delete_booked_movie_use_case.dart';
import '../../../home/domain/use_cases/get_booked_movies_use_case.dart';
import '../../../home/domain/use_cases/get_categories_use_case.dart';
import '../../data/dto/movie_details_dto.dart';
import '../../domain/use_cases/get_similar_use_case.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates>{
  MovieDetailsDto dto;
  late MovieDetailsDomainRepo domainRepo;

  HomeDataSources homeDataSources;
  late HomeDomainRepo homeDomainRepo;

  MovieDetailsCubit(this.dto,this.homeDataSources) : super(MovieDetailsInitState()) {
    domainRepo = MovieDetailsDataRepo(dto);
    homeDomainRepo = HomeDataRepo(homeDataSources);
  }

  //====================movies details=============
  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  List<ResultsEntity>? similarMovies = [];

  void getSimilarMovies(String movieId) async {
    emit(MovieDetailsGetSimilarLoadingState());
    //HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetSimilarUseCase getMoreLikeUseCase = GetSimilarUseCase(domainRepo);
    var result = await getMoreLikeUseCase.call(movieId);
    result.fold((l) {
      emit(MovieDetailsGetSimilarErrorState(l));
    }, (r) {
      similarMovies = r.results;
      emit(MovieDetailsGetSimilarSuccessState(r));
    });
  }


  //====================home=============
  List<ResultsEntity>? bookedMovies = [];

  Future<List<QueryDocumentSnapshot<ResultsModel>>> getBookedMoviesSnapLocal() async {
    emit(MovieDetailsGetBookedLoadingState());
    homeDomainRepo = HomeDataRepo(homeDataSources);
    GetBookedMoviesUseCase getBookedMoviesUseCase =
    GetBookedMoviesUseCase(homeDomainRepo);
    var result =
    await getBookedMoviesUseCase.call().then((value) => value.docs);
    emit(MovieDetailsGetBookedSuccessState());
    return result;
  }

  void getBookedMoviesLocal() async {
    emit(MovieDetailsGetBookedLoadingState());
    var docs = await getBookedMoviesSnapLocal();
    bookedMovies = docs.map((doc) {
      ResultsModel task = doc.data();
      return task;
    }).toList();
    emit(MovieDetailsGetBookedSuccessState());
  }

  void bookMovie(ResultsModel movie) async {
    emit(MovieDetailsGetBookedLoadingState());
    homeDomainRepo = HomeDataRepo(homeDataSources);
    BookMovieUseCase bookMovieUseCase = BookMovieUseCase(homeDomainRepo);
    try {
      bookMovieUseCase.call(movie);
      getBookedMoviesLocal();
      emit(MovieDetailsGetBookedSuccessState());
    } catch (e) {
      emit(MovieDetailsGetBookedErrorState());
    }
  }

  void deleteMovie(ResultsModel movie) async {
    emit(MovieDetailsGetBookedLoadingState());
    homeDomainRepo = HomeDataRepo(homeDataSources);
    DeleteBookedMovieUseCase deleteBookedMovieUseCase = DeleteBookedMovieUseCase(homeDomainRepo);
    try {
      deleteBookedMovieUseCase.call(movie);
      getBookedMoviesLocal();
      emit(MovieDetailsGetBookedSuccessState());
    } catch (e) {
      emit(MovieDetailsGetBookedErrorState());
    }
  }

  bool isBooked(ResultsEntity? movie) {
    return bookedMovies?.contains(movie) ?? false;
  }


  List<GenresEntity>? categories = [];
  List<GenresEntity>? mCategories = [];

  void getCategories(ResultsEntity movie) async {
    emit(MovieDetailsGetBookedLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetCategoriesUseCase getCategoriesUseCase =
    GetCategoriesUseCase(domainRepo);
    var result = await getCategoriesUseCase.call();
    result.fold((l) {
      emit(MovieDetailsGetBookedSuccessState());
    }, (r) {
      categories = r.genres;
      for(int i =0;i<categories!.length;i++){
        if(movie.genreIds!.contains(categories![i].id)){
          mCategories!.add(categories![i]);
        }
      }
      emit(MovieDetailsGetBookedErrorState());
    });
  }
}