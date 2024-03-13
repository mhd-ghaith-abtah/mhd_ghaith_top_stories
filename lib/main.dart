import 'package:flutter/material.dart';
import 'package:mhd_ghaith_top_stories/app/dependency_injection/dependency_injection.dart';
import 'package:mhd_ghaith_top_stories/app/top_stories_app.dart';

void main() async {
  /// flutter
  WidgetsFlutterBinding.ensureInitialized();

  /// dependency injection
  await initAppModule();

  runApp(TopStoriesApp());
}
