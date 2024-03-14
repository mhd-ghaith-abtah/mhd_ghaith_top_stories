part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoaded extends SplashState {}

class SavingAPIKey extends SplashState {}

class APIKeySavedSuccessfully extends SplashState {}

class APIKeySavingError extends SplashState {
  final String errorMessage;

  APIKeySavingError({required this.errorMessage});
}
