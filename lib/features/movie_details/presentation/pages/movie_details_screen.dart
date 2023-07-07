import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/text_styles.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';
import 'package:movie_app/features/movie_details/data/dto/movie_details_remote_dto.dart';
import 'package:movie_app/features/movie_details/presentation/manager/cubit.dart';
import 'package:movie_app/features/movie_details/presentation/manager/states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/components.dart';
import '../../../home/data/data_sources/remote_dto.dart';

class MovieDetailsScreen extends StatelessWidget {
  final ResultsEntity movie;

  MovieDetailsScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MovieDetailsCubit(MovieDetailsRemoteDto(), RemoteDto())..getCategories(movie)..getBookedMoviesLocal()..getSimilarMovies(movie.id!),
        child: BlocConsumer<MovieDetailsCubit, MovieDetailsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              color: AppColors.shadow,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  appBar: AppBar(
                    backgroundColor: AppColors.primary,
                    title: Text(
                      movie.title ?? "",
                      style: poppins20W600(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 217.h,
                                  width: double.infinity,
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie.backdropPath ?? "null"}",
                                    fit: BoxFit.cover,
                                  )),
                            ],
                          ),
                          const Icon(
                            Icons.play_circle,
                            size: 60,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Text(
                          maxLines: 1,
                          movie.title ?? "null",
                          style: poppins18W500().copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Text(
                          movie.releaseDate ?? "null",
                          style: poppins12W400().copyWith(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      SizedBox(
                        height: 199.h,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: poster(movie, MovieDetailsCubit.get(context).isBooked(movie),),
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 44.h,
                                  width: 245.w,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 9.w,
                                        crossAxisSpacing: 3.h,
                                        childAspectRatio: 25.w / 125.h,
                                      ),
                                      itemCount: MovieDetailsCubit.get(context).mCategories?.length??0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          alignment: Alignment.center,
                                          width: 65.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                  color: AppColors.border)),
                                          child: Text(
                                            MovieDetailsCubit.get(context).mCategories![index].name??"null",
                                            style: poppins12W400(
                                                color: Colors.white),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                SizedBox(
                                  height: 124.h,
                                  width: 231.w,
                                  child: Column(
                                    children: [
                                      Text(
                                        movie.overview ?? "null",
                                        maxLines: 5,
                                        style:
                                            poppins12W400(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.star,
                                            width: 20.w,
                                            height: 20.h,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 7.w,
                                          ),
                                          Text(
                                            movie.voteAverage ?? "null",
                                            style: poppins18W500(
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Container(
                        height: 264.h,
                        width: double.infinity,
                        color: AppColors.shadow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 13.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 19.w),
                              child: Text(
                                "Recommended",
                                style: poppins16W600()
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            Expanded(
                              child: MovieDetailsCubit.get(context)
                                      .similarMovies!
                                      .isNotEmpty
                                  ? ListView.builder(
                                      itemBuilder: (_, index) => GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(
                                              context,
                                              Routes.movieDetails,
                                              arguments: MovieDetailsCubit.get(context)
                                                  .similarMovies?[index]);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.poster,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            width: 97.w,
                                            height: 204.h,
                                            margin: EdgeInsets.only(
                                                right: 13.7.w,
                                                left: index == 0 ? 19.w : 0.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                poster(
                                                    MovieDetailsCubit.get(context)
                                                        .similarMovies?[index],
                                                    MovieDetailsCubit.get(context)
                                                        .isBooked(MovieDetailsCubit.get(
                                                                    context)
                                                                .similarMovies?[
                                                            index]),
                                                    width: 97,
                                                    height: 127,),
                                                SizedBox(
                                                  height: 4.3.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6.0.w),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        AppImages.star,
                                                        width: 10.w,
                                                        height: 9.h,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        MovieDetailsCubit.get(context)
                                                                .similarMovies?[
                                                                    index]
                                                                .voteAverage ??
                                                            "0.0",
                                                        style: poppins12W400()
                                                            .copyWith(
                                                                color:
                                                                    Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6.0.w),
                                                  child: Text(
                                                    MovieDetailsCubit.get(context)
                                                            .similarMovies?[
                                                                index]
                                                            .title ??
                                                        "null",
                                                    style: poppins12W400()
                                                        .copyWith(
                                                            color: Colors.white),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6.0.w),
                                                  child: Text(
                                                    MovieDetailsCubit.get(context)
                                                            .similarMovies?[
                                                                index]
                                                            .releaseDate ??
                                                        "null",
                                                    style: poppins8W400(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                              ],
                                            )),
                                      ),
                                      itemCount: MovieDetailsCubit.get(context)
                                          .similarMovies
                                          ?.length,
                                      scrollDirection: Axis.horizontal,
                                    )
                                  : Shimmer.fromColors(
                                      baseColor: AppColors.poster,
                                      highlightColor: AppColors.shadow,
                                      child: Container(
                                        width: double.infinity,
                                        height: 204.h,
                                        color: Colors.white,
                                      )),
                            ),
                            SizedBox(
                              height: 14.1.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
