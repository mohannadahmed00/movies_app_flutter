import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/data/models/movies_model.dart';
import 'package:movie_app/features/movie_details/data/dto/movie_details_dto.dart';
import 'package:movie_app/features/movie_details/domain/repositories/movie_details_domain_repo.dart';

class MovieDetailsDataRepo extends MovieDetailsDomainRepo{
  MovieDetailsDto dto;

  MovieDetailsDataRepo(this.dto);

  @override
  Future<Either<Failures, MoviesModel>> getMoreLike(String movieId)=>dto.getMoreLike(movieId);

}