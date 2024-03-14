import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mhd_ghaith_top_stories/app/app_configurations/assets.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/route_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/values_manager.dart';
import 'package:mhd_ghaith_top_stories/app/dependency_injection/dependency_injection.dart';
import 'package:mhd_ghaith_top_stories/core/utils/utils.dart';
import 'package:mhd_ghaith_top_stories/features/splash/presentation/bloc/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit _splashCubit;

  _bind() async {
    _splashCubit = instance<SplashCubit>();
    await _splashCubit.saveAPIKeyToStorage();
    await Future.delayed(AppDurations.superSlow,
        () => context.pushReplacement(Routes.topStoriesRoute));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _unBind() async => await _splashCubit.close();

  @override
  void dispose() {
    _unBind();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _splashCubit,
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) async {
            if (state is APIKeySavingError) {
              await Utils.showToast(state.errorMessage);
            }
          },
          child: _screenContent(),
        ),
      );

  Widget _screenContent() => Scaffold(
        body: Center(
          child: Lottie.asset(
            Assets.splashAnimation,
            height: 1.sh,
            animate: true,
            repeat: true,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
        ),
      );
}
