import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/data_sources/remote_dto.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(RemoteDto())..getBookedMoviesLocal()..getPopularMovies()..getUpComingMovies()..getTopRatedMovies()..getCategories(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state){},
        builder: (context, state) {
          return Container(
            color: AppColors.primary,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: HomeCubit.get(context).tabs[HomeCubit.get(context).tabIndex],
                bottomNavigationBar: SizedBox(
                  height: 75.h,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.border))
                    ),
                    child: BottomNavigationBar(
                      elevation: 12,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      // selectedLabelStyle: TextStyle(color: AppColors.onPrimary),
                      // unselectedLabelStyle: poppins12W400().copyWith(color: AppColors.onPrimary),
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: AppColors.primary,
                      onTap: (value) {
                        HomeCubit.get(context).changeTab(value);
                      },
                      currentIndex: HomeCubit.get(context).tabIndex,
                      items: [
                        BottomNavigationBarItem(
                            backgroundColor: AppColors.primary,
                            icon: HomeCubit.get(context).tabIndex==0?Image.asset(AppImages.icHome,width: 26.w,height: 38.h,):Image.asset(AppImages.unIcHome,width: 26.w,height: 38.h,),
                            label: "HOME"),
                        BottomNavigationBarItem(
                            backgroundColor: AppColors.primary,
                            icon: HomeCubit.get(context).tabIndex==1?Image.asset(AppImages.icSearch,width: 31.w,height: 38.h,):Image.asset(AppImages.unIcSearch,width: 31.w,height: 38.h,),
                            label: "SEARCH"),
                        BottomNavigationBarItem(
                            backgroundColor: AppColors.primary,
                            icon: HomeCubit.get(context).tabIndex==2?Image.asset(AppImages.icCategory,width: 33.w,height: 36.h,):Image.asset(AppImages.unIcCategory,width: 33.w,height: 36.h,),
                            label: "BROWSE"),
                        BottomNavigationBarItem(
                            backgroundColor: AppColors.primary,
                            icon: HomeCubit.get(context).tabIndex==3?Image.asset(AppImages.icWatchList,width: 44.w,height: 37.h,):Image.asset(AppImages.unIcWatchList,width: 44.w,height: 37.h,),
                            label: "WATCHLIST"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
