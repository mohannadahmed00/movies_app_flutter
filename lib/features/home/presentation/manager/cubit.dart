import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movies_model.dart';
import 'package:movie_app/features/home/domain/entities/category_entity.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';
import 'package:movie_app/features/home/domain/use_cases/book_movie_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/delete_booked_movie_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/get_booked_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/get_category_movies_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/get_popular_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/get_top_rated_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/get_upcoming_use_case.dart';
import 'package:movie_app/features/home/domain/use_cases/search_movies_use_case.dart';
import 'package:movie_app/features/home/presentation/pages/tabs/category_tab.dart';
import 'package:movie_app/features/home/presentation/pages/tabs/search_tab.dart';
import 'package:movie_app/features/home/presentation/pages/tabs/watch_list_tab.dart';

import '../../data/data_sources/home_data_sources.dart';
import '../../data/repositories/home_data_repo.dart';
import '../../domain/repositories/home_domain_repo.dart';
import '../pages/tabs/home_tab.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeDataSources homeDataSources;
  late HomeDomainRepo homeDomainRepo;

  HomeCubit(this.homeDataSources) : super(HomeInitState()) {
    homeDomainRepo = HomeDataRepo(homeDataSources);
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  //=================tabs=================
  int tabIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const CategoryTab(),
    const WatchListTab(),
  ];

  void changeTab(int index) {
    categoryMovies = [];
    tabIndex = index;
    emit(HomeChangeTabState());
  }

  //=================popular=================
  List<ResultsEntity>? popularMovies = [];

  void getPopularMovies() async {
    emit(HomeGetPopularLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetPopularUseCase getPopularUseCase = GetPopularUseCase(domainRepo);
    var result = await getPopularUseCase.call();
    result.fold((l) {
      emit(HomeGetPopularErrorState(l));
    }, (r) {
      popularMovies = r.results;
      emit(HomeGetPopularSuccessState(r));
    });
  }

  //=================upcoming=================
  List<ResultsEntity>? upcomingMovies = [];

  void getUpComingMovies() async {
    emit(HomeGetUpComingLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetUpComingUseCase getUpComingUseCase = GetUpComingUseCase(domainRepo);
    var result = await getUpComingUseCase.call();
    result.fold((l) {
      emit(HomeGetUpComingErrorState(l));
    }, (r) {
      upcomingMovies = r.results;
      emit(HomeGetUpComingSuccessState(r));
    });
  }

  //=================top rated=================
  List<ResultsEntity>? topRatedMovies = [];

  void getTopRatedMovies() async {
    emit(HomeGetTopRatedLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetTopRatedUseCase getTopRatedUseCase = GetTopRatedUseCase(domainRepo);
    var result = await getTopRatedUseCase.call();
    result.fold((l) {
      emit(HomeGetTopRatedErrorState(l));
    }, (r) {
      topRatedMovies = r.results;
      emit(HomeGetTopRatedSuccessState(r));
    });
  }

  //=================search=================
  TextEditingController searchController = TextEditingController();
  List<ResultsEntity>? resultMovies = [];

  void searchMovies() async {
    emit(HomeSearchLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    SearchMoviesUseCase searchMoviesUseCase = SearchMoviesUseCase(domainRepo);
    var result = await searchMoviesUseCase.call(searchController.text);
    result.fold((l) {
      emit(HomeSearchErrorState(l));
    }, (r) {
      resultMovies = r.results;
      emit(HomeSearchSuccessState(r));
    });
  }

  void clearSearch(){
    resultMovies!.clear();
    emit(HomeSearchClearState());
  }

  //=================category=================
  List<GenresEntity>? categories = [];

  List<ResultsEntity>? categoryMovies = [];

  void getCategories() async {
    emit(HomeGetCategoriesLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetCategoriesUseCase getCategoriesUseCase =
        GetCategoriesUseCase(domainRepo);
    var result = await getCategoriesUseCase.call();
    result.fold((l) {
      emit(HomeGetCategoriesErrorState(l));
    }, (r) {
      categories = r.genres;
      emit(HomeGetCategoriesSuccessState(r));
    });
  }

  void getCategoryMovies(String categoryId) async {
    emit(HomeGetCategoryMoviesLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetCategoryMoviesUseCase getCategoryMoviesUseCase =
    GetCategoryMoviesUseCase(domainRepo);
    var result = await getCategoryMoviesUseCase.call(categoryId);
    result.fold((l) {
      emit(HomeGetCategoryMoviesErrorState(l));
    }, (r) {
      categoryMovies= r.results;
      emit(HomeGetCategoryMoviesSuccessState(r));
    });
  }

  //=================book Movie=================
  List<ResultsEntity>? bookedMovies = [];

  void bookMovie(ResultsModel movie) async {
    emit(HomeGetBookedLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    BookMovieUseCase bookMovieUseCase = BookMovieUseCase(domainRepo);
    try {
      bookMovieUseCase.call(movie);
      getBookedMoviesLocal();
      emit(HomeGetBookedSuccessState());
    } catch (e) {
      emit(HomeGetBookedErrorState());
    }
  }

  void deleteMovie(ResultsModel movie) async {
    emit(HomeDeleteBookedLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    DeleteBookedMovieUseCase deleteBookedMovieUseCase = DeleteBookedMovieUseCase(domainRepo);
    try {
      deleteBookedMovieUseCase.call(movie);
      getBookedMoviesLocal();
      emit(HomeDeleteBookedSuccessState());
    } catch (e) {
      emit(HomeDeleteBookedErrorState());
    }
  }


  Future<QuerySnapshot<ResultsModel>> getBookedMoviesSnap() async {
    emit(HomeGetCategoriesLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetBookedMoviesUseCase getBookedMoviesUseCase =
        GetBookedMoviesUseCase(domainRepo);
    var result = await getBookedMoviesUseCase.call();
    emit(HomeGetBookedSuccessState());
    return result;
  }

  void getBookedMovies(AsyncSnapshot<QuerySnapshot<ResultsModel>> snapshot) async {
    emit(HomeGetCategoriesLoadingState());
    bookedMovies = snapshot.data?.docs.map((doc) {
          ResultsModel task = doc.data();
          //task.id = doc.id;
          return task;
        }).toList() ??
        [];
    emit(HomeGetBookedSuccessState());
  }

  //================just try local============
  Future<List<QueryDocumentSnapshot<ResultsModel>>> getBookedMoviesSnapLocal() async {
    emit(HomeGetCategoriesLoadingState());
    HomeDomainRepo domainRepo = HomeDataRepo(homeDataSources);
    GetBookedMoviesUseCase getBookedMoviesUseCase =
        GetBookedMoviesUseCase(domainRepo);
    var result =
        await getBookedMoviesUseCase.call().then((value) => value.docs);
    emit(HomeGetBookedSuccessState());
    return result;
  }

  void getBookedMoviesLocal() async {
    //emit(HomeGetCategoriesLoadingState());
    var docs = await getBookedMoviesSnapLocal();
    bookedMovies = docs.map((doc) {
          ResultsModel task = doc.data();
          //task.id = doc.id;
          return task;
        }).toList();
    emit(HomeGetBookedSuccessState());
  }

//=================check local movies=================
  bool isBooked(ResultsEntity? movie) {
    return bookedMovies?.contains(movie) ?? false;
  }
}
