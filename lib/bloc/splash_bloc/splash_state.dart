part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashLoadedState extends SplashState {}

class SplashDisabledState extends SplashState {}

class SplashErrorState extends SplashState {
  final String error;

  SplashErrorState(this.error);
}
