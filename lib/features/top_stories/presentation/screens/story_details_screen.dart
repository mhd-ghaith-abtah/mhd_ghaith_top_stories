import 'dart:io';

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
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _appBar(context),
            _screenContent(context),
          ],
        ),
      );

  Widget _backgroundImage() => FlexibleSpaceBar(
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
      );

  Widget _backButton(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => context.pop(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.orange.withOpacity(.5),
            ),
            padding: EdgeInsets.all(1.r),
            child: Icon(
              Platform.isAndroid
                  ? Icons.arrow_back_outlined
                  : Icons.arrow_back_ios_new_outlined,
            ),
          ),
        ),
      );

  Widget _appBar(BuildContext context) => SliverAppBar(
        pinned: true,
        floating: true,
        snap: true,
        expandedHeight:
            ScreenUtil().orientation == Orientation.portrait ? .35.sh : .8.sh,
        leading: _backButton(context),
        flexibleSpace: _backgroundImage(),
      );

  Widget _contentContainer(String content) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(5.r),
        child: Text(
          content,
          style: getRegularTextStyle(
            color: ColorManager.white,
            fontSize: FontSize.s14,
          ),
        ),
      );

  SliverToBoxAdapter _screenContent(BuildContext context) => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              color: ColorManager.blue.withOpacity(.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _contentContainer(
                    widget.story.byline?.isNotEmpty == true
                        ? widget.story.byline!
                        : AppStrings.unknownAuthor,
                  ),
                  _contentContainer(intl.DateFormat.yMMMEd()
                      .format(widget.story.createdDate ?? DateTime.now())),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            if (widget.story.abstract?.isNotEmpty == true) ...[
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Text(
                  AppStrings.abstract,
                  style: getBoldTextStyle(
                    color: ColorManager.navy,
                    fontSize: FontSize.s20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Text(
                  widget.story.abstract!,
                  style: getBoldTextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s18,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
            if (widget.story.url?.isNotEmpty == true)
              Center(
                child: ElevatedButton(
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
                ),
              ),
            SizedBox(height: 40.h),
          ],
        ),
      );
}
