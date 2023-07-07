import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/home_domain_repo.dart';

class GetUpComingUseCase {
  HomeDomainRepo homeDomainRepo;

  GetUpComingUseCase(this.homeDomainRepo);

  Future<Either<Failures, MoviesEntity>> call() => homeDomainRepo.getUpComing();
}
