import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mhd_ghaith_top_stories/app/app_configurations/assets.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/font_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/values_manager.dart';
import 'package:mhd_ghaith_top_stories/app/dependency_injection/dependency_injection.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/core/utils/utils.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/bloc/top_stories_bloc/top_stories_bloc.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/widgets/news_article_gird_item.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/widgets/news_article_tile.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/widgets/shimmer_grid_loading_placeholder.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/widgets/shimmer_list_loading_placeholder.dart';

class TopStoriesScreen extends StatefulWidget {
  const TopStoriesScreen({super.key});

  @override
  State<TopStoriesScreen> createState() => _TopStoriesScreenState();
}

class _TopStoriesScreenState extends State<TopStoriesScreen> {
  late final TopStoriesBloc _topStoriesBloc;
  late final TextEditingController _searchController;

  _bind() {
    _topStoriesBloc = instance<TopStoriesBloc>()
      ..add(GetTopStories(section: Section.home));

    _searchController = TextEditingController();
    _searchController.addListener(_searchTypingListener);
  }

  _searchTypingListener() =>
      _topStoriesBloc.add(SearchInStories(searchText: _searchController.text));

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _unBind() async {
    await _topStoriesBloc.close();
    _searchController.removeListener(_searchTypingListener);
    _searchController.dispose();
  }

  @override
  void dispose() {
    _unBind();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _topStoriesBloc,
        child: BlocListener<TopStoriesBloc, TopStoriesState>(
          listener: (context, state) async {
            if (state is TopStoriesError) {
              await Utils.showToast(state.errorMessage);
            }
          },
          child: _screenContent(context),
        ),
      );

  Widget _changeViewButton() => IconButton(
        onPressed: () => _topStoriesBloc.add(ChangeViewType()),
        icon: BlocBuilder<TopStoriesBloc, TopStoriesState>(
          builder: (context, state) => Icon(
            _topStoriesBloc.isListView
                ? Icons.grid_view_rounded
                : Icons.format_list_bulleted_rounded,
          ),
        ),
      );

  Widget _clearTextFieldButton() =>
      BlocBuilder<TopStoriesBloc, TopStoriesState>(
        builder: (context, state) {
          if (_searchController.text.isNotEmpty) {
            return IconButton(
              iconSize: 20.r,
              padding: EdgeInsets.zero,
              splashRadius: 1,
              onPressed: () => _searchController.clear(),
              icon: Icon(
                Icons.close,
                size: 20.r,
              ),
            );
          } else {
            return Container();
          }
        },
      );

  Widget _filterButton() => IconButton(
        onPressed: () {},
        icon: const Icon(Icons.filter_alt_rounded),
      );

  Widget _searchTextField() => TextField(
        controller: _searchController,
        style: getBoldTextStyle(
          color: ColorManager.black,
          fontSize: FontSize.s16,
        ),
        decoration: const InputDecoration(
          hintText: AppStrings.searchHint,
          border: UnderlineInputBorder(),
        ),
      );

  AppBar _topStoriesAppBar() => AppBar(
        title: _searchTextField(),
        actions: [
          _clearTextFieldButton(),
          _filterButton(),
          _changeViewButton(),
        ],
      );

  Widget _errorView(String errorMessage, {bool noInternet = false}) =>
      SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: .3.sh),
            if (noInternet)
              Lottie.asset(
                Assets.noInternetAnimation,
                animate: true,
                repeat: true,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                errorMessage,
                style: getBoldTextStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s18,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () =>
                  _topStoriesBloc.add(GetTopStories(section: Section.home)),
              child: Text(
                AppStrings.tryAgain,
                style: getBoldTextStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      );

  Widget _loadingView() {
    if (_topStoriesBloc.isListView) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const ListContentPlaceholder(),
      );
    } else {
      return GridView.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: ScreenUtil().orientation == Orientation.portrait
              ? .24.sh
              : .44.sh,
        ),
        itemBuilder: (context, index) => const GridContentPlaceholder(),
      );
    }
  }

  Widget _emptyView() => SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: .2.sh),
            Lottie.asset(
              Assets.noResultAnimation,
              animate: true,
              repeat: true,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                AppStrings.emptyNews,
                style: getBoldTextStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s20,
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      );

  Widget _loadedView(List<TopStoryModel> stories, {bool isSearch = false}) {
    if (stories.isEmpty) {
      return _emptyView();
    } else {
      if (!isSearch) {
        return RefreshIndicator(
          onRefresh: () async => await Future.delayed(
            AppDurations.fast,
            () => _topStoriesBloc.add(GetTopStories(
              section: Section.home,
              forceFromAPI: true,
            )),
          ),
          child: _storiesView(stories),
        );
      } else {
        return _storiesView(stories);
      }
    }
  }

  Widget _storiesView(List<TopStoryModel> stories) => _topStoriesBloc.isListView
      ? ListView.builder(
          itemCount: stories.length,
          itemBuilder: (context, index) => NewsArticleTile(
            story: stories[index],
          ) //adding the required animations at the end
              .animate()
              .slideX(
                begin: -10,
                end: 0,
                duration: AppDurations.megaFast,
                curve: Curves.fastEaseInToSlowEaseOut,
              ),
        )
      : GridView.builder(
          itemCount: stories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: ScreenUtil().orientation == Orientation.portrait
                ? .24.sh
                : .44.sh,
          ),
          itemBuilder: (context, index) => NewsArticleGridItem(
            story: stories[index],
          ),
        ).animate().slideX(
            begin: 10,
            end: 0,
            duration: AppDurations.megaFast,
            curve: Curves.fastEaseInToSlowEaseOut,
          );

  Widget _screenContent(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: _topStoriesAppBar(),
          body: BlocBuilder<TopStoriesBloc, TopStoriesState>(
            builder: (context, state) {
              if (state is TopStoriesLoading) {
                return _loadingView();
              } else if (state is TopStoriesLoaded) {
                return _loadedView(
                  state.stateType == TopStoriesBlocStateType.search
                      ? _topStoriesBloc.storiesSearchResult
                      : _topStoriesBloc.stories,
                  isSearch: state.stateType == TopStoriesBlocStateType.search,
                );
              } else if (state is TopStoriesError) {
                return _errorView(
                  state.errorMessage,
                  noInternet:
                      state.stateType == TopStoriesBlocStateType.noInternet,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      );
}
