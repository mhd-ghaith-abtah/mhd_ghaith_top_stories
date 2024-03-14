import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/font_manager.dart';

class NewsArticleGridItem extends StatelessWidget {
  final String? author;
  final String? title;
  final String? imageUrl;

  const NewsArticleGridItem({
    super.key,
    required this.author,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left part: Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: imageUrl != null && imageUrl?.isNotEmpty == true
                  ? Hero(
                      tag: imageUrl!,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl!,
                        width: 200.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (_, __, ___) => Container(
                          color: Colors.black12,
                          width: 200.w,
                          height: 100.h,
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: ColorManager.navy,
                            size: 30.r,
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          width: 200.w,
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
                      width: 200.w,
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
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title of the article
                    if (title != null)
                      Text(
                        title!,
                        maxLines: 2,
                        style: getBoldTextStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 3),
                    // Author
                    if (author != null)
                      Text(
                        author!,
                        style: getRegularTextStyle(color: ColorManager.black),
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
      );
}
