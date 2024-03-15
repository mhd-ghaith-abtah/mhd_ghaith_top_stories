import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/font_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/route_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/core/utils/constants.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

class StoryDetailsScreen extends StatefulWidget {
  final TopStoryModel story;

  const StoryDetailsScreen({super.key, required this.story});

  @override
  State<StoryDetailsScreen> createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: .25.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                color: ColorManager.orange.withOpacity(.5),
                child: Text(
                  widget.story.title ?? Constants.empty,
                  style: getBoldTextStyle(
                      color: ColorManager.black, fontSize: FontSize.s18),
                ),
              ),
              background: widget.story.multimedia?.isNotEmpty == true &&
                      widget.story.multimedia?.first.url != null &&
                      widget.story.multimedia?.first.url?.isNotEmpty == true
                  ? Hero(
                      tag: widget.story.multimedia!.first.url!,
                      child: CachedNetworkImage(
                        imageUrl: widget.story.multimedia!.first.url!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (_, __, ___) => Container(
                          color: Colors.black12,
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: ColorManager.navy,
                            size: 30.r,
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
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
                      color: Colors.black12,
                      child: Icon(
                        Icons.photo,
                        size: 40.r,
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.blue,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(5.r),
                      child: Text(
                        widget.story.byline!,
                        style: getRegularTextStyle(
                            color: ColorManager.white, fontSize: FontSize.s14),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.blue,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(5.r),
                      child: Text(
                        intl.DateFormat.yMMMEd()
                            .format(widget.story.createdDate!),
                        style: getRegularTextStyle(
                            color: ColorManager.white, fontSize: FontSize.s14),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.story.abstract!,
                  style: getBoldTextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s18,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.push(
                      RoutesPaths.storyDetailsWebViewPath,
                      extra: widget.story),
                  child: Text(
                    AppStrings.seeMore,
                    style: getBoldTextStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
