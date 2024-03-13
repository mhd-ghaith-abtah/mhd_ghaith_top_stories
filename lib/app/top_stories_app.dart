import 'package:flutter/material.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/app_lifecycle_event_handler/app_lifecycle_event_handler.dart';
import 'package:mhd_ghaith_top_stories/app/top_stories_material.dart';

class TopStoriesApp extends StatefulWidget {
  /// named constructor
  const TopStoriesApp._internal();

  /// singleton or single instance
  static const TopStoriesApp _instance = TopStoriesApp._internal();

  /// factory
  factory TopStoriesApp() => _instance;

  @override
  State<TopStoriesApp> createState() => _KeepFitAppState();
}

class _KeepFitAppState extends State<TopStoriesApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(AppLifecycleEventHandler());
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(AppLifecycleEventHandler());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TopStoriesMaterial();
}
