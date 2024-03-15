import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mhd_ghaith_top_stories/app/dependency_injection/dependency_injection.dart';
import 'package:mhd_ghaith_top_stories/features/splash/presentation/screens/splash_screen.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/screens/story_details_screen.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/screens/story_details_web_view_screen.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/screens/top_stories_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String topStoriesRoute = "/topStories";
  static const String storyDetailsRoute = "storyDetails";
  static const String storyDetailsWebViewRoute = "storyDetailsWebView";
}

class RoutesPaths {
  static const String storyDetailsPath =
      "${Routes.topStoriesRoute}/${Routes.storyDetailsRoute}";
  static const String storyDetailsWebViewPath =
      "${Routes.topStoriesRoute}/${Routes.storyDetailsRoute}/${Routes.storyDetailsWebViewRoute}";
}

class RouteGenerator {
  static final GoRouter router = GoRouter(
    observers: [GoRouterObserver()],
    routes: <GoRoute>[
      GoRoute(
        path: Routes.splashRoute,
        builder: (BuildContext context, GoRouterState state) {
          initSplashModule();
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: Routes.topStoriesRoute,
        builder: (BuildContext context, GoRouterState state) {
          initTopStoriesModule();
          return const TopStoriesScreen();
        },
        routes: <GoRoute>[
          GoRoute(
            path: Routes.storyDetailsRoute,
            builder: (BuildContext context, GoRouterState state) =>
                StoryDetailsScreen(story: state.extra as TopStoryModel),
            routes: <GoRoute>[
              GoRoute(
                path: Routes.storyDetailsWebViewRoute,
                builder: (BuildContext context, GoRouterState state) =>
                    StoryDetailsWebViewScreen(
                        story: state.extra as TopStoryModel),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class GoRouterObserver extends NavigatorObserver {
  final Logger _logger = Logger();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _logger.i("didPush: ${route.settings.name}");

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _logger.i("didPop: ${route.settings.name}");

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _logger.i("didRemove: ${route.settings.name}");

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _logger.i(
          "didReplace old route: ${oldRoute?.settings.name}, didReplace new route: ${newRoute?.settings.name}");
}
