import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppLifecycleEventHandler extends WidgetsBindingObserver {
  static final AppLifecycleEventHandler _instance =
      AppLifecycleEventHandler._();

  AppLifecycleEventHandler._();

  factory AppLifecycleEventHandler() => _instance;

  final Logger _logger = Logger();

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    _logger.i(
        "<<<<<<<<<<<<<<<<<<< app current state >>>>>>>>>>>>>>>>>>>>>>: ${state.name}");

    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }
}
