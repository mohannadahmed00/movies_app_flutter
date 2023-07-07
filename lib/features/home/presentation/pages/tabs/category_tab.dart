import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/text_styles.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/components.dart';
import '../../manager/cubit.dart';
import '../../manager/states.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is HomeGetCategoryMoviesSuccessState){
            showDialog(
              context: context,
              builder: (context) => ListView.builder(itemBuilder: (_,index){
                var movie = state.moviesEntity.results![index];
                return GestureDetector(onTap:(){
                  Navigator.pushNamed(
                      context,
                      Routes.movieDetails,
                      arguments: movie);
                },child: searchItem(movie));
              },itemCount: state.moviesEntity.results?.length??0,)
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 43.h,
                ),
                Text(
                  "Browse Category",
                  style: poppins22W600(),
                ),
                SizedBox(
                  height: 12.5.h,
                ),
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 38.w,
                      mainAxisSpacing: 47.w,
                      childAspectRatio: 158.w / 90.h,
                    ),
                    itemCount: 15,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: (){
                          String categoryId = HomeCubit.get(context).categories![index].id.toString();
                          HomeCubit.get(context).getCategoryMovies(categoryId);
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.r)),
                                foregroundDecoration: BoxDecoration(
                                    color: const Color(0xa8000000),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.asset(
                                    AppImages.searchImg,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Center(
                              child: Text(
                                HomeCubit.get(context).categories![index].name??"null",
                                style:
                                    poppins14W500().copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
