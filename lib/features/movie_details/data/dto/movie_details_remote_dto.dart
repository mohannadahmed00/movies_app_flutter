import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/home/data/models/movies_model.dart';
import 'package:movie_app/features/movie_details/data/dto/movie_details_dto.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/constants.dart';

class MovieDetailsRemoteDto extends MovieDetailsDto {
  Dio dio = Dio();

  @override
  Future<Either<Failures, MoviesModel>> getMoreLike(String movieId) async {
    try {
      var response = await dio.get(
        "${Constants.baseUrlApi}${EndPoints.similar.replaceAll("{movie_id}", movieId)}",
        options: Options(
          headers: {
            'Authorization': "Bearer ${Constants.accessToken}",
          },
        ),
      );
      MoviesModel model = MoviesModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailures(e.toString()));
    }
  }
}
