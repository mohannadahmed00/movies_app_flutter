import '../../data/models/movies_model.dart';
import '../repositories/home_domain_repo.dart';

class BookMovieUseCase {
  HomeDomainRepo homeDomainRepo;

  BookMovieUseCase(this.homeDomainRepo);

  Future<void> call(ResultsModel movie) => homeDomainRepo.addMovie(movie);
}
