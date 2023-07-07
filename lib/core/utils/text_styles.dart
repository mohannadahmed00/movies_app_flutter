import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

TextStyle poppins20W600({Color color = AppColors.onPrimary}) => GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600, color: color);
TextStyle poppins14W300({Color color = AppColors.onPrimary}) => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w300, color: color);
TextStyle poppins14W400() => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.onPrimary);
TextStyle poppins8W400() => GoogleFonts.poppins(fontSize: 8.sp, fontWeight: FontWeight.w400, color: Colors.grey);
TextStyle poppins14W500() => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.onPrimary);
TextStyle poppins12W400({Color color = AppColors.onPrimary}) => GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: color);
TextStyle poppins18W500({Color color = AppColors.onPrimary}) => GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w500, color: color);
TextStyle poppins16W600() => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onPrimary);
TextStyle poppins22W600() => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white);
