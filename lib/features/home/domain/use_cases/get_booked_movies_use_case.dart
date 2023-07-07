import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/movies_model.dart';
import '../repositories/home_domain_repo.dart';

class GetBookedMoviesUseCase {
  HomeDomainRepo homeDomainRepo;

  GetBookedMoviesUseCase(this.homeDomainRepo);

  Future<QuerySnapshot<ResultsModel>> call()  => homeDomainRepo.getMovies();
}
