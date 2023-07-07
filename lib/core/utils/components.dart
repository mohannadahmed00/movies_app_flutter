import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import '../../features/home/domain/entities/movies_entity.dart';
import 'app_assets.dart';


Widget poster(ResultsEntity? movie,bool booked,{double width=129,double height=199,Function? callBack}){
  String? img = movie?.posterPath;
  return img==null?Shimmer.fromColors(
    baseColor: AppColors.poster,
    highlightColor: AppColors.border,
    child: Container(
      width: width.w,
      height: height.h,
      color: AppColors.poster,
    ),
  ):ClipRRect(
    borderRadius: BorderRadius.circular(4.r),
    child: Stack(
      children: [
        Image.network(
          "https://image.tmdb.org/t/p/w500$img",
          width: width.w,
          height: height.h,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Shimmer.fromColors(
              baseColor: AppColors.poster,
              highlightColor: AppColors.shadow,
              child: Container(
                width: width.w,
                height: height.h,
                color: Colors.white,
              ),
            );
          },
        ),
        booked?
        Visibility(
          visible: callBack!=null,
          child: GestureDetector(
            onTap: (){
              callBack!(movie,booked);
            },
            child: Image.asset(
              AppImages.icBookMark,
              width: 27.w,
              height: 36.h,
            ),
          ),
        ):
        Visibility(
          visible: callBack!=null,
          child: GestureDetector(
            onTap: (){
              callBack!(movie,booked);
            },
            child: Image.asset(
              AppImages.unIcBookMark,
              width: 27.w,
              height: 36.h,
            ),
          ),
        )
      ],
    ),
  );
}

Widget searchItem(ResultsEntity movie, [Function? callBack]){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(
        width: 318.w,
        height: 140.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            movie.posterPath==null?
            Shimmer.fromColors(
              baseColor: AppColors.poster,
              highlightColor: AppColors.border,
              child: Container(
                width: 140.w,
                height: 150.h,
                color: Colors.white,
              ),
            ):
            Stack(
              children: [
                Image.network("https://image.tmdb.org/t/p/w500${movie.posterPath}",width: 140.w,height: 150.h,fit: BoxFit.fill,),
                Visibility(
                  visible: callBack!=null,
                  child: GestureDetector(
                    onTap: (){
                      callBack!(movie);
                    },
                    child: Image.asset(AppImages.icBookMark,width: 27.w,
                      height: 36.h,),
                  ),
                )
              ],
            ),
            SizedBox(width: 5.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h,),
                SizedBox(width:250.w,child: Text(movie.title??"null",maxLines: 1,overflow: TextOverflow.ellipsis,style: poppins16W600().copyWith(color: Colors.white),)),
                SizedBox(height: 2.h,),
                Text(movie.releaseDate??"null",style: poppins16W600().copyWith(color: Colors.grey),),
                SizedBox(height: 2.h,),
                SizedBox(width:250.w,child: Text(movie.overview??"null",maxLines: 3,overflow: TextOverflow.ellipsis,style: poppins16W600().copyWith(color: Colors.grey),)),
                SizedBox(height: 5.h,),
              ],
            )
          ],
        ),
      ),
      SizedBox(height: 13.5.h,),
      Container(
        width: 358.w,
        height: 1.h,
        color: AppColors.border,
      ),
      SizedBox(height: 13.5.h,),
    ],
  );
}
/*Widget defaultFormField(
        {required TextEditingController controller,
        required String label,
        required Function validate,
        bool isPassword = false}) =>
    TextFormField(
      controller: controller,
      validator: (value) {
        validate(value);
        return null;
      },
      obscureText: isPassword,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12))),
    );

Widget productCard(ProductDataEntity product) {
  return Container(
      margin: EdgeInsets.only(left: 16.w),
      width: 158.w,
      height: 211.h,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r)),
                    child: Image.network(
                      product.imageCover ?? "",
                      fit: BoxFit.cover,
                      width: 158.w,
                      height: 122.h,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          //_isLoading = false;
                          return child;
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 158.w,
                            height: 122.h,
                            color: Colors.white,
                          ),
                          //period: Duration(milliseconds: 1000),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "${product.title}",
                        style: poppins14W400(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Review (${product.ratingsAverage})",
                            style: poppins12W400(),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Image.asset(
                            AppImages.star,
                            width: 15.w,
                            height: 15.h,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        "EGP ${product.price}",
                        style: poppins12W400(),
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 8.w,
              top: 8.h,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.onPrimary,
                  borderRadius: BorderRadius.circular(50.r)
                ),
                child: Image.asset(
                  AppImages.icLikes,
                  fit: BoxFit.fill,
                  width: 16.w,
                  height: 16.h,
                ),
              )),
          Positioned(
              right: 8.w,
              bottom: 8.h,
              child: Image.asset(
                AppImages.add,
                width: 30.w,
                height: 30.h,
              )),
        ],
      ));
}

Widget menuItem(String category, bool isSelected, int itemIndex) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: isSelected ? 0.w : 7.w),
    width: 137.w,
    height: 82.h,
    decoration: BoxDecoration(
      color: isSelected ? AppColors.onPrimary : AppColors.menuColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(itemIndex == 0 ? 10.r : 0.r)),
    ),
    child: Row(
      children: [
        Visibility(
          visible: isSelected,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            width: 7.w,
            height: 72.h,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        SizedBox(width: 98.w, child: Text(category, style: poppins14W500())),
      ],
    ),
  );
}*/
