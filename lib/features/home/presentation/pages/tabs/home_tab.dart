import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/components.dart';
import '../../manager/cubit.dart';
import '../../manager/states.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              HomeCubit.get(context).popularMovies!.isNotEmpty
                  ? ImageSlideshow(
                      width: double.infinity,
                      height: 289.h,
                      initialPage: 0,
                      indicatorColor: Colors.transparent,
                      indicatorBackgroundColor: Colors.transparent,
                      autoPlayInterval: 10000,
                      isLoop: true,
                      children: HomeCubit.get(context).popularMovies!.map((e) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 217.h,
                                    width: double.infinity,
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w500${e.backdropPath ?? "null"}",
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  height: 13.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 162.w, right: 67.w),
                                  child: Text(
                                    maxLines: 1,
                                    e.title ?? "null",
                                    style: poppins14W500().copyWith(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 162.w),
                                  child: Text(
                                    e.releaseDate ?? "null",
                                    style: poppins12W400()
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0.h,
                              left: 21.w,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      Routes.movieDetails,
                                      arguments: e);
                                },
                                child: poster(
                                      e, HomeCubit.get(context).isBooked(e),
                                      callBack: (movie, booked) {
                                    if (booked) {
                                      HomeCubit.get(context).deleteMovie(movie);
                                    } else {
                                      HomeCubit.get(context).bookMovie(movie);
                                    }
                                  }),
                              ),
                            ),
                            const Icon(
                              Icons.play_circle,
                              size: 60,
                              color: Colors.white,
                            )
                          ],
                        );
                      }).toList(),
                    )
                  : Shimmer.fromColors(
                      baseColor: AppColors.poster,
                      highlightColor: AppColors.shadow,
                      child: Container(
                        width: double.infinity,
                        height: 289.h,
                        color: Colors.white,
                      )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      Container(
                        height: 187.h,
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
                                "New Releases",
                                style: poppins16W600()
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Expanded(
                                child: HomeCubit.get(context)
                                        .upcomingMovies!
                                        .isNotEmpty
                                    ? ListView.builder(
                                        itemBuilder: (_, index) => GestureDetector(
                                          onTap: (){
                                            Navigator.pushNamed(
                                                context,
                                                Routes.movieDetails,
                                                arguments: HomeCubit.get(context)
                                                    .upcomingMovies?[index]);
                                          },
                                          child: Container(
                                              width: 97.w,
                                              height: 128.h,
                                              margin: EdgeInsets.only(
                                                  right: 13.7.w,
                                                  left: index == 0 ? 19.w : 0.w),
                                              child: poster(
                                                  HomeCubit.get(context)
                                                      .upcomingMovies?[index],
                                                  HomeCubit.get(context).isBooked(
                                                      HomeCubit.get(context)
                                                              .upcomingMovies?[
                                                          index]),
                                                  callBack: (movie, booked) {
                                                if (booked) {
                                                  HomeCubit.get(context)
                                                      .deleteMovie(movie);
                                                } else {
                                                  HomeCubit.get(context)
                                                      .bookMovie(movie);
                                                }
                                              })),
                                        ),
                                        itemCount: HomeCubit.get(context)
                                            .upcomingMovies
                                            ?.length,
                                        scrollDirection: Axis.horizontal,
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: AppColors.poster,
                                        highlightColor: AppColors.shadow,
                                        child: Container(
                                          width: double.infinity,
                                          height: 128.h,
                                          color: Colors.white,
                                        ))),
                            SizedBox(
                              height: 14.1.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 29.h,
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
                              child: HomeCubit.get(context)
                                      .topRatedMovies!
                                      .isNotEmpty
                                  ? ListView.builder(
                                      itemBuilder: (_, index) => GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(
                                              context,
                                              Routes.movieDetails,
                                              arguments: HomeCubit.get(context)
                                                  .topRatedMovies?[index]);
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
                                                    HomeCubit.get(context)
                                                        .topRatedMovies?[index],
                                                    HomeCubit.get(context)
                                                        .isBooked(HomeCubit.get(
                                                                    context)
                                                                .topRatedMovies?[
                                                            index]),
                                                    width: 97,
                                                    height: 127,
                                                    callBack: (movie, booked) {
                                                  if (booked) {
                                                    HomeCubit.get(context)
                                                        .deleteMovie(movie);
                                                  } else {
                                                    HomeCubit.get(context)
                                                        .bookMovie(movie);
                                                  }
                                                }),
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
                                                        HomeCubit.get(context)
                                                                .topRatedMovies?[
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
                                                    HomeCubit.get(context)
                                                            .topRatedMovies?[
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
                                                    HomeCubit.get(context)
                                                            .topRatedMovies?[
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
                                      itemCount: HomeCubit.get(context)
                                          .topRatedMovies?.length,
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
              )
            ],
          );
        });
  }
}
