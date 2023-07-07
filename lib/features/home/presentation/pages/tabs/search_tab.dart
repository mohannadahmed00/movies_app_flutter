import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/text_styles.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/components.dart';
import '../../manager/cubit.dart';
import '../../manager/states.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is HomeSearchErrorState) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(state.failures.message),
          ),
        );
      }
    }, builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            height: 43.h,
          ),
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: TextField(
              style: poppins16W600(),
              controller: HomeCubit.get(context).searchController,
              cursorColor: Colors.white,
              onChanged: (value) {
                if (value == "") {
                  HomeCubit.get(context).clearSearch();
                } else {
                  HomeCubit.get(context).searchMovies();
                }
              },
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  AppImages.search,
                  width: 16.w,
                  height: 16.h,
                ),
                fillColor: AppColors.border,
                filled: true,
                contentPadding: EdgeInsets.only(top: 28.h),
                hintText: "Search",
                hintStyle: poppins14W500().copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: const BorderSide(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(
            height: 29.h,
          ),
          Visibility(
              visible: HomeCubit.get(context).resultMovies!.isEmpty,
              child: Expanded(child: Image.asset(AppImages.noMovies))),
          Visibility(
              visible: HomeCubit.get(context).resultMovies!.isNotEmpty,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      var movie = HomeCubit.get(context).resultMovies![index];
                      return GestureDetector(onTap:(){
                        Navigator.pushNamed(
                            context,
                            Routes.movieDetails,
                            arguments: movie);
                      },child: searchItem(movie));
                    },
                    itemCount: HomeCubit.get(context).resultMovies!.length,
                  ),
                ),
              )),
        ],
      );
    });
  }
}
