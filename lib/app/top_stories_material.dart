import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mhd_ghaith_top_stories/app/app_configurations/app_configurations.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/route_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/theme_manager.dart';
import 'package:mhd_ghaith_top_stories/core/utils/constants.dart';

class TopStoriesMaterial extends StatefulWidget {
  const TopStoriesMaterial._internal();

  static const TopStoriesMaterial _instance = TopStoriesMaterial._internal();

  factory TopStoriesMaterial() => _instance;

  @override
  State<TopStoriesMaterial> createState() => _KeepFitMaterialState();
}

class _KeepFitMaterialState extends State<TopStoriesMaterial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(
          Constants.screenDesignWidth,
          Constants.screenDesignHeight,
        ),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConfigurations.applicationName,
          routerConfig: RouteGenerator.router,
          theme: getApplicationTheme(),
        ),
      );
}
