import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class GridContentPlaceholder extends StatelessWidget {
  const GridContentPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Shimmer.fromColors(
          baseColor: ColorManager.grey,
          highlightColor: ColorManager.lightGrey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200.w,
                height: 100.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: ColorManager.grey,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 10.h,
                        color: ColorManager.grey,
                        margin: EdgeInsets.only(bottom: 8.h),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10.h,
                        color: ColorManager.grey,
                        margin: EdgeInsets.only(bottom: 8.h),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10.h,
                        color: ColorManager.grey,
                        margin: EdgeInsets.only(bottom: 8.h),
                      ),
                      Container(
                        width: 100.w,
                        height: 10.h,
                        color: ColorManager.grey,
                        margin: EdgeInsets.only(bottom: 8.h),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
