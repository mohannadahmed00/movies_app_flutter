import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';
import 'package:movie_app/features/movie_details/domain/repositories/movie_details_domain_repo.dart';

class GetSimilarUseCase{
  MovieDetailsDomainRepo domainRepo;

  GetSimilarUseCase(this.domainRepo);

  Future<Either<Failures,MoviesEntity>> call(String movieId)=> domainRepo.getMoreLike(movieId);
}