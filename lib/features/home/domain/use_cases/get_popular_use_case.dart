import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/home_domain_repo.dart';

class GetPopularUseCase {
  HomeDomainRepo homeDomainRepo;

  GetPopularUseCase(this.homeDomainRepo);

  Future<Either<Failures, MoviesEntity>> call() => homeDomainRepo.getPopular();
}
