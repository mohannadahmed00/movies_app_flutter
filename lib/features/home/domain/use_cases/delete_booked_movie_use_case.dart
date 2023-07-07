import '../../data/models/movies_model.dart';
import '../repositories/home_domain_repo.dart';

class DeleteBookedMovieUseCase {
  HomeDomainRepo homeDomainRepo;

  DeleteBookedMovieUseCase(this.homeDomainRepo);

  Future<void> call(ResultsModel movie) => homeDomainRepo.deleteMovie(movie);
}
