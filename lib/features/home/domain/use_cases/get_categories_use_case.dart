import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/category_entity.dart';
import '../../../../core/error/failures.dart';
import '../repositories/home_domain_repo.dart';

class GetCategoriesUseCase {
  HomeDomainRepo homeDomainRepo;

  GetCategoriesUseCase(this.homeDomainRepo);

  Future<Either<Failures, CategoryEntity>> call() => homeDomainRepo.getCategories();
}
