import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/font_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/route_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

class NewsArticleTile extends StatelessWidget {
  final TopStoryModel? story;

  const NewsArticleTile({super.key, required this.story});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.push(RoutesPaths.storyDetailsPath, extra: story),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            children: [
              Row(
                children: [
                  // Left part: Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: story?.multimedia?.isNotEmpty == true &&
                            story?.multimedia?.first.url != null &&
                            story?.multimedia?.first.url?.isNotEmpty == true
                        ? Hero(
                            tag: story!.multimedia!.first.url!,
                            child: CachedNetworkImage(
                              imageUrl: story!.multimedia!.first.url!,
                              width: 150.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (_, __, ___) =>
                                  Container(
                                color: Colors.black12,
                                width: 150.w,
                                height: 100.h,
                                child: LoadingAnimationWidget.fourRotatingDots(
                                  color: ColorManager.navy,
                                  size: 30.r,
                                ),
                              ),
                              errorWidget: (_, __, ___) => Container(
                                width: 150.w,
                                height: 100.h,
                                color: Colors.black12,
                                child: Icon(
                                  Icons.error_outline,
                                  size: 40.r,
                                  color: ColorManager.red,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 150.w,
                            height: 100.h,
                            color: Colors.black12,
                            child: Icon(
                              Icons.photo,
                              size: 40.r,
                            ),
                          ),
                  ),

                  // Content
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title of the article
                          Text(
                            story!.title!,
                            maxLines: 2,
                            style: getBoldTextStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          // Author
                          Text(
                            story?.byline?.isNotEmpty == true
                                ? story!.byline!
                                : AppStrings.unknownAuthor,
                            style:
                                getRegularTextStyle(color: ColorManager.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
