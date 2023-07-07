import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/home/presentation/manager/cubit.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../manager/states.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 43.h,
                ),
                Text(
                  "Watchlist",
                  style: poppins22W600(),
                ),
                SizedBox(
                  height: 12.5.h,
                ),
                HomeCubit.get(context).bookedMovies!.isEmpty
                    ? Expanded(
                        child: Center(
                            child: Expanded(
                                child: Image.asset(AppImages.noMovies))))
                    : Expanded(
                        child: ListView.builder(
                        itemBuilder: (_, index) {
                          var movie = HomeCubit.get(context).bookedMovies![index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(
                                  context,
                                  Routes.movieDetails,
                                  arguments: movie);
                            },
                            child: searchItem(movie,(movie){
                              HomeCubit.get(context).deleteMovie(movie);
                            }),
                          );
                        },
                        itemCount: HomeCubit.get(context).bookedMovies!.length,
                      ))
              ],
            ),
          );
        });
  }
}
