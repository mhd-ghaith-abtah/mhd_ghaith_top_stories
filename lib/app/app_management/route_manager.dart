import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mhd_ghaith_top_stories/app/dependency_injection/dependency_injection.dart';
import 'package:mhd_ghaith_top_stories/features/splash/presentation/screens/splash_screen.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/screens/top_stories_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String topStoriesRoute = "/topStories";
}

class RoutesPaths {}

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
